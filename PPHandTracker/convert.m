//// 
////  convert.m
////  PPHandTracker
////
////  Created by alpha on 2022/1/18.
////  
////
//
//#import "convert.h"
//
//@implementation convert
//
//
//- (UIImage *)imageFromPixelBuffer:(CVPixelBufferRef)pixelBufferRef {
//    CVImageBufferRef imageBuffer =  pixelBufferRef;
//    
//    CVPixelBufferLockBaseAddress(imageBuffer, 0);
//    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
//    size_t width = CVPixelBufferGetWidth(imageBuffer);
//    size_t height = CVPixelBufferGetHeight(imageBuffer);
//    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
//    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
//    
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, baseAddress, bufferSize, NULL);
//    
//    CGImageRef cgImage = CGImageCreate(width, height, 8, 32, bytesPerRow, rgbColorSpace, kCGImageAlphaNoneSkipFirst | kCGBitmapByteOrderDefault, provider, NULL, true, kCGRenderingIntentDefault);
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    CGDataProviderRelease(provider);
//    CGColorSpaceRelease(rgbColorSpace);
//    
//    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
//    return image;
//}
//
//
//
//
//
//- (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image
//{
//    NSDictionary *options = @{
//        (NSString*)kCVPixelBufferCGImageCompatibilityKey : @YES,
//        (NSString*)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES,
//        (NSString*)kCVPixelBufferIOSurfacePropertiesKey: [NSDictionary dictionary]
//    };
//    CVPixelBufferRef pxbuffer = NULL;
//    
//    CGFloat frameWidth = CGImageGetWidth(image);
//    CGFloat frameHeight = CGImageGetHeight(image);
//    
//    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                          frameWidth,
//                                          frameHeight,
//                                          kCVPixelFormatType_32BGRA,
//                                          (__bridge CFDictionaryRef) options,
//                                          &pxbuffer);
//    
//    NSParameterAssert(status == kCVReturnSuccess && pxbuffer != NULL);
//    
//    CVPixelBufferLockBaseAddress(pxbuffer, 0);
//    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
//    NSParameterAssert(pxdata != NULL);
//    
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGContextRef context = CGBitmapContextCreate(pxdata,
//                                                 frameWidth,
//                                                 frameHeight,
//                                                 8,
//                                                 CVPixelBufferGetBytesPerRow(pxbuffer),
//                                                 rgbColorSpace,
//                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipFirst);
//    NSParameterAssert(context);
//    CGContextConcatCTM(context, CGAffineTransformIdentity);
//    CGContextDrawImage(context, CGRectMake(0,
//                                           0,
//                                           frameWidth,
//                                           frameHeight),
//                       image);
//    CGColorSpaceRelease(rgbColorSpace);
//    CGContextRelease(context);
//    
//    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
//    
//    return pxbuffer;
//}
//
//
////other
//- (UIImage *)convert:(CVPixelBufferRef)pixelBuffer {
//    CIImage *ciImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
//    
//    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
//    CGImageRef videoImage = [temporaryContext
//                             createCGImage:ciImage
//                             fromRect:CGRectMake(0, 0, CVPixelBufferGetWidth(pixelBuffer), CVPixelBufferGetHeight(pixelBuffer))];
//    
//    UIImage *uiImage = [UIImage imageWithCGImage:videoImage];
//    CGImageRelease(videoImage);
//    
//    return uiImage;
//}
//
//@end
