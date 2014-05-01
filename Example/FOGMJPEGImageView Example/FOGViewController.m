//
//  FOGViewController.m
//  FOGMJPEGImageView Example
//
//  Created by Richard McGuire on 2014-04-23.
//  Copyright (c) 2014 Foggy. All rights reserved.
//

#import "FOGViewController.h"

@interface FOGViewController ()

@end

@implementation FOGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.mjpegImageView startWithURL:[NSURL URLWithString:@"http://161.115.4.53/mjpg/video.mjpg?camera=1"]];
}

@end
