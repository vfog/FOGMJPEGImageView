//
//  FOGViewController.m
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

#import "FOGViewController.h"
#import "Camera.h"

@interface FOGViewController()

@property (nonatomic, strong, readwrite) NSArray *cameras;
@property (nonatomic, strong, readwrite) Camera *selectedCamera;
           
@end

@implementation FOGViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.mjpegImageView.delegate = self;
    
    // camera data obtained from http://www.mjpeg.net/webcams
    self.cameras = @[[[Camera alloc] initWithName:@"Grand Valley State University (Allendale Michigan United States)"
                                              URL:[NSURL URLWithString:@"http://148.61.97.229/mjpg/video.mjpg?camera=1"]],
                     [[Camera alloc] initWithName:@"Webcam (Allendale Michigan United States)"
                                              URL:[NSURL URLWithString:@"http://148.61.161.209/mjpg/video.mjpg?camera=1"]],
                     [[Camera alloc] initWithName:@"Detroit Traffic (Detroit Michigan United States)"
                                              URL:[NSURL URLWithString:@"http://216.8.159.21/mjpg/video.mjpg?camera=1"]],
                     [[Camera alloc] initWithName:@"Webcam (Kingston Ontario Canada)"
                                              URL:[NSURL URLWithString:@"http://130.15.110.15/mjpg/video.mjpg?camera=1"]],
                     [[Camera alloc] initWithName:@"Spring Grove (Spring Grove Minnesota United States)"
                                              URL:[NSURL URLWithString:@"http://204.248.124.203/mjpg/video.mjpg?camera=1"]]];
    
    [self.cameraPicker selectRow:0 inComponent:0 animated:NO];
    self.selectedCamera = self.cameras[0];
    self.stopButton.enabled = NO;
}

#pragma mark - FOGViewController

- (IBAction)invokeStart:(id)sender
{
    self.startButton.enabled = NO;
    
    [self.mjpegImageView startWithURL:self.selectedCamera.URL];

    self.stopButton.enabled = YES;
}

- (IBAction)invokeStop:(id)sender
{
    self.stopButton.enabled = NO;
    
    [self.mjpegImageView stop];
    
    self.startButton.enabled = YES;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.cameras count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Camera *camera = (Camera *)[self.cameras objectAtIndex:row];
    
    return camera.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedCamera = (Camera *)[self.cameras objectAtIndex:row];
}

#pragma mark - FOGMJPEGImageViewDelegate Methods

- (void)FOGMJPEGImageViewDidReceiveImage:(FOGMJPEGImageView *)mjpegImageView
{
    // Success!
}

- (void)FOGMJPEGImageView:(FOGMJPEGImageView *)mjpegImageView loadingImgaeDidFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Failed loading MJPEG Stream"
                                                   delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
    [self invokeStop:nil];
}

@end
