//
//  UIImage+Common.m
//  yingzi_iOS
//
//  Created by YW on 15/7/15.
//  Copyright (c) 2015年 lyw. All rights reserved.
//

#import "UIImage+Common.h"

@implementation UIImage (UIImage_Common)

// 对图片尺寸进行压缩
- (UIImage*)scaledToSize:(CGSize)targetSize
{
    UIImage * sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    UIGraphicsBeginImageContext(targetSize); // this will crop
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
//        NSLog(@"could not scale image");
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}
//旋转图片
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality
{
    if (highQuality) {
        targetSize = CGSizeMake(2*targetSize.width, 2*targetSize.height);
    }
    return [self scaledToSize:targetSize];
}
+ (UIImage *)imageWithColor:(UIColor *)aColor{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (NSMutableArray *)getImgWidthAndHeight:(NSString *)imgUrl
{
    NSMutableArray * resArr = [[NSMutableArray alloc] init];
    UIImageView * imgview = [[UIImageView alloc] init];
    NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:imgUrl]] returningResponse:nil error:nil];
    
   [imgview setImage:[UIImage imageWithData:data]];
    //异步下载
//    NSURL *url = [NSURL URLWithString:imgUrl];   
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30.0f]; //maximal timeout is 30s
//    NSOperationQueue *queue = [NSOperationQueue mainQueue];
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
////        
//    }];

    NSString * wh =  NSStringFromCGSize(CGSizeMake(imgview.image.size.width,imgview.image.size.height));//打印获取的网络图片的宽度和高度
    float resW = 0;
    float resH = 0;
    float maxW = SCREEN_WIDTH - 20;
    if (wh) {
        wh = [wh substringFromIndex:1];
        wh = [wh substringToIndex:wh.length - 1];
        NSArray * originalWhArr = [wh componentsSeparatedByString:@","];
        float w = [originalWhArr[0] floatValue];
        float h = [originalWhArr[1] floatValue];
        if (w <= maxW) {
            resW = w;
            resH = h;
        }else{
            resW = maxW;
            resH =maxW/w*h;
        }
    }
    [resArr addObject:[NSString stringWithFormat:@"%f",resW]];
    [resArr addObject:[NSString stringWithFormat:@"%f",resH]];
    return resArr;
}

@end
