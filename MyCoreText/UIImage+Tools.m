//
//  UIImage+Tools.m
//  MyCoreText
//
//  Created by 杜甲 on 2018/5/27.
//  Copyright © 2018年 杜甲. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)
- (CGPoint)colorAtPoint:(CGPoint)point {
    if (self.size.width > 0.0 && self.size.height > 0.0) {
        int bitmapInfo = kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast;
        //第一步 先把图片缩小 加快计算速度，但越小结果误差可能越大。
        // 如果width或者height是1.123456789这样的数（小数位数太多），context会创建失败，因此
        // 我们取整。
        CGSize thumbSize = CGSizeMake(floor(self.size.width), floor(self.size.height));
        if (point.x >= 0.0 && point.x < thumbSize.width &&
            point.y >= 0.0 && point.y < thumbSize.height) {
            NSUInteger bytesPerPixel = 4;
            NSUInteger bytesPerRow = bytesPerPixel * thumbSize.width;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(NULL,
                                                         thumbSize.width,
                                                         thumbSize.height,
                                                         8,// bits per component
                                                         bytesPerRow,
                                                         colorSpace,
                                                         bitmapInfo);
            
            CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
            CGContextDrawImage(context, drawRect, self.CGImage);
            CGColorSpaceRelease(colorSpace);
            
            //第二步 取点的像素值
            UIColor *color = nil;
            unsigned char* data = CGBitmapContextGetData(context);
            int p_x = -1;
//            int p_
            if (data != nil) {
                
                for (int x = 0; x < thumbSize.width; x ++) {
                    for (int y = 0 ; y < thumbSize.height; y++) {
                        int offset = (y * bytesPerRow) + (x * bytesPerPixel);
                        CGFloat alpha = ((CGFloat)data[offset+3]) / 255.0;
                        CGFloat red = alpha != 0.0 ? (((CGFloat)data[offset]) / alpha / 255.0) : 0.0;
                        CGFloat green = alpha != 0.0 ? (((CGFloat)data[offset+1]) / alpha / 255.0) : 0.0;
                        CGFloat blue = alpha != 0.0 ? (((CGFloat)data[offset+2]) / alpha / 255.0) : 0.0;
                        if (alpha > 0) {
                            NSLog(@"x = %d , y = %d  , red = %f  alpha = %f ", x , y ,red  ,alpha);
                            p_x = x;
                            return CGPointMake(p_x, 0);
                        }
                        
                        color = [[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha];
                    }
                }
                
            }
            CGContextRelease(context);
            
            return CGPointMake(p_x, 0);
        }
    }
    return CGPointMake(-1, -1);;
}
@end
