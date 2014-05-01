//
//  FOGMJPEGImageMarker.m
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

#import "FOGJPEGImageMarker.h"

@implementation FOGJPEGImageMarker

+ (NSData *)JPEGStartMarker
{
    static NSData *startMarker;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        const uint8_t bytes[2] = { 0xFF, 0xD8 };
        startMarker = [NSData dataWithBytes:bytes length:2];
    });
    
    return startMarker;
}

+ (NSData *)JPEGEndMarker
{
    static NSData *endMarker;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        const uint8_t bytes[2] = { 0xFF, 0xD9 };
        endMarker = [NSData dataWithBytes:bytes length:2];
    });
    
    return endMarker;
}

@end
