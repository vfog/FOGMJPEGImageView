//
//  FOGMJPEGImageView.m
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
#import "FOGMJPEGImageView.h"
#import "FOGJPEGImageMarker.h"

@interface FOGMJPEGImageView() <FOGMJPEGDataReaderDelegate>

@property (nonatomic, readwrite) FOGMJPEGDataReader *dataReader;

@property (nonatomic, readwrite) BOOL isReadingData;

@end

@implementation FOGMJPEGImageView

#pragma mark - Initializers

- (instancetype)init
{
    self = [super init];
    if ( !self ) {
        return nil;
    }

    self.dataReader = [[FOGMJPEGDataReader alloc] init];
    self.dataReader.delegate = self;
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( !self ) {
        return nil;
    }
    
    self.dataReader = [[FOGMJPEGDataReader alloc] init];
    self.dataReader.delegate = self;
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( !self ) {
        return nil;
    }
    
    self.dataReader = [[FOGMJPEGDataReader alloc] init];
    self.dataReader.delegate = self;
    
    return self;
}

- (NSURLSession *)URLSession
{
    return self.dataReader.URLSession;
}

#pragma mark - FOGMJPEGImageView

- (void)startWithURL:(NSURL *)url
{
    if ( !url ) {
        return;
    }
    
    if ( self.isReadingData ) {
        return;
    }
    
    self.isReadingData = YES;
    [self.dataReader startReadingFromURL:url];
}

- (void)stop
{
    if ( !self.isReadingData ) {
        return;
    }
    
    [self.dataReader stop];
    self.isReadingData = NO;
}

#pragma mark - FOGMJPEGDataReaderDelegate

- (void)FOGMJPEGDataReader:(FOGMJPEGDataReader *)reader receivedImage:(UIImage *)image
{
    self.image = image;
    if ([self.delegate respondsToSelector:@selector(FOGMJPEGImageViewDidReceiveImage:)]) {
        [self.delegate FOGMJPEGImageViewDidReceiveImage:self];
    }
}

- (void)FOGMJPEGDataReader:(FOGMJPEGDataReader *)reader loadingImageDidFailWithError:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(FOGMJPEGImageView:loadingImgaeDidFailWithError:)]) {
        [self.delegate FOGMJPEGImageView:self loadingImgaeDidFailWithError:error];
    }
}

@end
