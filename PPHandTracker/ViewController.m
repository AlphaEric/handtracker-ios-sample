//
//  ViewController.m
//  testHand
//
//  Created by Alpha on 2022/1/18.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <HandTracker/HandTracker.h>

#import "Camera.h"

@interface ViewController ()<AVCaptureAudioDataOutputSampleBufferDelegate,TrackerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISwitch *switchTracking;
@property (nonatomic,strong) Camera * camera;
@property (nonatomic,strong) HandTracker * handTracker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _camera = [Camera new];
    [_camera setSampleBufferDelegate:self];
    [_camera start];
    
    _handTracker = [[HandTracker alloc] init];
    [_handTracker startGraph];
    [_handTracker setDelegate:self];
    
    _imageView.backgroundColor = UIColor.blueColor;
    
}

#pragma mark - TrackerDelegate

-(void)handTracker:(HandTracker *)handTracker didOutputLandmarks:(NSArray<Landmark *> *)landmarks{
    NSLog(@"%@",landmarks);
}

- (void)handTracker:(HandTracker *)handTracker didOutputPixelBuffer:(CVPixelBufferRef)pixelBuffer{
    
    CIImage *ciImage = [CIImage imageWithCVImageBuffer:pixelBuffer];
    __weak ViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.switchTracking.isOn) {
            weakSelf.imageView.image = [UIImage imageWithCIImage:ciImage];
        }
    });
    
    /**error : why imageWithCVImageBuffer must be outside of the block */
    //    __weak ViewController *weakSelf = self;
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        if (weakSelf.switchTracking.isOn) {
    //            weakSelf.imageView.image = [UIImage imageWithCIImage:[CIImage imageWithCVImageBuffer:pixelBuffer]];
    //        }
    //    });
    
    
}

#pragma mark - AVCaptureAudioDataOutputSampleBufferDelegate

-(void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection{
    
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [_handTracker processVideoFrame:pixelBuffer];
    CIImage * ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    __weak ViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong ViewController *strongSelf = weakSelf;
        if (!strongSelf.switchTracking.isOn) {
            strongSelf.imageView.image = [UIImage imageWithCIImage:ciImage];
        }
    });
    
}



@end
