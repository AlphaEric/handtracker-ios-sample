//
//  Camera.h
//  testHand
//
//  Created by LingoAce on 2022/1/17.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureDevice *device;
@property (nonatomic,strong) AVCaptureDeviceInput *input;
@property (nonatomic,strong) AVCaptureVideoDataOutput *output;

-(void)setSampleBufferDelegate:(nullable id<AVCaptureAudioDataOutputSampleBufferDelegate>)delegate;
-(void)start;
-(void)stop;

@end

NS_ASSUME_NONNULL_END
