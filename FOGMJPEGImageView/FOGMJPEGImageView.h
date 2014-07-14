//
//  FOGMJPEGImageView.h
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

#import "FOGMJPEGImageViewDelegate.h"

@interface FOGMJPEGImageView : UIImageView<NSURLSessionDataDelegate>

@property (nonatomic, strong, readonly) NSURLSession *URLSession;
@property (nonatomic, weak) id<FOGMJPEGImageViewDelegate> delegate;

/**
 Begins reading MJPEG data from the given URL.
 
 Successive calls to `startWithURL:` without first calling `stop` will be ignored.
 
 @param url The URL of the MJPEG feed, if nil is passed the call will be ignored.
 */
- (void)startWithURL:(NSURL *)url;

/**
 Stops reading MJPEG data.
 
 Successive calls to stop will be ignored and have no effect.
 */
- (void)stop;

@end
