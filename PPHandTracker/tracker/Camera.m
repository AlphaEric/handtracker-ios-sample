//
//  Camera.m
//  testHand
//
//  Created by LingoAce on 2022/1/17.
//

#import "Camera.h"
#import <AVFoundation/AVFoundation.h>

@implementation Camera
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        [self config];
    }
    return self;
}

-(void)setup{
    _session = [AVCaptureSession new];
    _device = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    _output = [AVCaptureVideoDataOutput new];
}

-(void)config{
    [_output setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey : [NSNumber numberWithInt:kCVPixelFormatType_32BGRA]}];
//    _output.videoSettings = @{(NSString*)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)};
    [_session addInput:_input];
    [_session addOutput:_output];
    [_session setSessionPreset:AVCaptureSessionPresetPhoto];
    if (@available(iOS 13.0, *)) {
        [_session.connections[0] setVideoOrientation:AVCaptureVideoOrientationPortrait];
        [_session.connections[0] setVideoMirrored:YES];
    } else {
        // nonsupport
    }
}

-(void)setSampleBufferDelegate:(nullable id<AVCaptureVideoDataOutputSampleBufferDelegate>)delegate {
    [_output setSampleBufferDelegate:delegate queue:dispatch_get_main_queue()];
}

-(void)start{
    [_session startRunning];
}

-(void)stop{
    [_session stopRunning];
}


@end
