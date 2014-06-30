//
//  FOGMJPEGDataReader.h
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

@protocol FOGMJPEGDataReaderDelegate;

@interface FOGMJPEGDataReader : NSObject<NSURLSessionDataDelegate>

/**
 The URL session used by the data reader to fetch and receive the MJPEG data.
 */
@property (nonatomic, strong, readonly) NSURLSession *URLSession;

/**
 The object that acts as the delegate of the receiving `FOGMJPEGDataReader`.
 */
@property (nonatomic, weak) id<FOGMJPEGDataReaderDelegate> delegate;

/**
 Begins reading MJPEG data from the given URL.
 
 @param URL The URL to make a request for MJPEG data.
 */
- (void)startReadingFromURL:(NSURL *)URL;

/**
 Stops reading MJPEG data.
 */
- (void)stop;

@end

@protocol FOGMJPEGDataReaderDelegate

/**
 Tells the delegate that the data reader received an image, this method is invoked on the main thread.
 */
- (void)FOGMJPEGDataReader:(FOGMJPEGDataReader *)reader receivedImage:(UIImage *)image;

@end
