//
//  FOGMJPEGImageViewDelegate.h
//  
//
//  Created by Jan Koch on 14.07.14.
//
//

#import <Foundation/Foundation.h>

@class FOGMJPEGImageView;

@protocol FOGMJPEGImageViewDelegate <NSObject>

@optional

/**
 Tells the delegate that the mjpeg image view received an image, this method is invoked on the main thread.
 */
- (void)FOGMJPEGImageViewDidReceiveImage:(FOGMJPEGImageView *)mjpegImageView;

/**
 Tells the delegate that the mjpeg image view failed loading the stream, this method is invoked on the main thread.
 */
- (void)FOGMJPEGImageView:(FOGMJPEGImageView *)mjpegImageView loadingImgaeDidFailWithError:(NSError *)error;

@end
