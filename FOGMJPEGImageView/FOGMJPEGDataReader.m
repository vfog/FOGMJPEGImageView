//
//  FOGMJPEGDataReader.m
//  
//  Copyright (c) 2014 Richard McGuire
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "FOGMJPEGDataReader.h"
#import "FOGJPEGImageMarker.h"

@interface FOGMJPEGDataReader()

@property (nonatomic, strong, readwrite) NSURLSession *URLSession;

@property (nonatomic, strong) NSOperationQueue *processingQueue;

@property (nonatomic, strong, readwrite) NSURLSessionDataTask *dataTask;

@property (nonatomic, strong, readwrite) NSMutableData *receivedData;

@end

@implementation FOGMJPEGDataReader

#pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if ( !self ) {
        return nil;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];

    self.processingQueue = [[NSOperationQueue alloc] init];
    self.URLSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:self.processingQueue];
                             
    return self;
}

#pragma mark - FOGMJPEGDataReader

- (void)startReadingFromURL:(NSURL *)URL
{
    self.receivedData = [[NSMutableData alloc] init];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    self.dataTask = [self.URLSession dataTaskWithRequest:request];
    [self.dataTask resume];
}

- (void)stop
{
    [self.dataTask cancel];
    self.dataTask = nil;
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
    
    // if we don't have an end marker then we can continue
    NSRange endMarkerRange = [self.receivedData rangeOfData:[FOGJPEGImageMarker JPEGEndMarker]
                                                    options:0
                                                      range:NSMakeRange(0, [self.receivedData length])];
    if ( endMarkerRange.location == NSNotFound ) {
        return;
    }
    
    // if we don't have a start marker prior to the end marker discard bytes and continue
    NSRange startMarkerRange = [self.receivedData rangeOfData:[FOGJPEGImageMarker JPEGStartMarker]
                                                      options:0
                                                        range:NSMakeRange(0, endMarkerRange.location)];
    if ( startMarkerRange.location == NSNotFound ) {
        // todo: should trim receivedData to endMarkerRange.location + 2 until end
        return;
    }
    
    NSUInteger imageDataLength = (endMarkerRange.location + 2) - startMarkerRange.location;
    NSRange imageDataRange = NSMakeRange(startMarkerRange.location, imageDataLength);
    NSData *imageData = [self.receivedData subdataWithRange:imageDataRange];
    UIImage *image = [UIImage imageWithData:imageData scale:0.5];
    
    if ( image ) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong id<FOGMJPEGDataReaderDelegate> strongDelegate = self.delegate;
            [strongDelegate FOGMJPEGDataReader:self receivedImage:image];
        });
    }
    
    NSUInteger newStartLocation = endMarkerRange.location + 2;
    NSUInteger newDataLength = [self.receivedData length] - newStartLocation;
    NSData *unusedData = [self.receivedData subdataWithRange:NSMakeRange(newStartLocation, newDataLength)];
    self.receivedData = [NSMutableData dataWithData:unusedData];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (error.code == kCFURLErrorCancelled) {
        // Manually cancelled request
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong id<FOGMJPEGDataReaderDelegate> strongDelegate = self.delegate;
        [strongDelegate FOGMJPEGDataReader:self loadingImageDidFailWithError:error];
    });
}

@end
