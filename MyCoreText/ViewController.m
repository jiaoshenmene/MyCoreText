//
//  ViewController.m
//  MyCoreText
//
//  Created by 杜甲 on 2018/5/16.
//  Copyright © 2018年 杜甲. All rights reserved.
//

#import "ViewController.h"
#import "MyLabel1.h"
#import "MyView.h"

#import "UIImage+Tools.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyLabel1 *label = [[MyLabel1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.font = [UIFont systemFontOfSize:23];
//    label.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:label];
    
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:@"？"];//2  ， ？！ 。   ิ124。
    
    
    [attString addAttributes:@{NSFontAttributeName : label.font } range:NSMakeRange(0, attString.length)];
    
    
    CGRect rect1 = [attString boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesDeviceMetrics context:nil];
    NSLog(@"rect1 = %@",NSStringFromCGRect(rect1));
    
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
    [self.view addSubview:v1];
    v1.backgroundColor = [UIColor grayColor];
    
    UIView *l2 = [[UIView alloc] initWithFrame:rect1];
    l2.backgroundColor = [UIColor greenColor];
    l2.center = CGPointMake(v1.center.x, v1.center.y);
    [self.view addSubview:l2];

    MyView *l1 = [[MyView alloc] initWithFrame:CGRectMake(( CGRectGetWidth(v1.frame) - ceil(rect1.size.width)  ) / 2 , 0,  ceil(rect1.size.width ) + 50, 100)];
    l1.text = attString.string;

    l1.font = label.font;
    l1.backgroundColor = [UIColor clearColor];
//    l1.alpha = 0.5f;
    [v1 addSubview:l1];


//    dispatch_async(dispatch_get_main_queue(), ^{
    UIImage *image = [ViewController getImageFromView:l1 size:CGSizeMake(CGRectGetWidth(l1.bounds), CGRectGetHeight(l1.bounds))];

        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.backgroundColor = [UIColor grayColor];



        imageView.frame = CGRectMake(CGRectGetMinX(l1.frame), CGRectGetMaxY(l1.bounds), CGRectGetWidth(l1.bounds), CGRectGetHeight(l1.bounds) * 0.3);
        [v1 addSubview:imageView];
        CGPoint p = [image colorAtPoint:CGPointMake(1, 2)];
        

//    });
    
    l1.frame = CGRectMake(( CGRectGetWidth(v1.frame) - ceil(rect1.size.width)  ) / 2 - p.x, 0,  ceil(rect1.size.width ) + 50, 100);
    
    
    
}


+(UIImage *)getImageFromView:(UIView *)theView size:(CGSize)size
{
    //UIGraphicsBeginImageContext(theView.bounds.size);
    UIGraphicsBeginImageContextWithOptions(size, NO, theView.layer.contentsScale);
    [theView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}





//根据图片获取图片的主色调
+(UIColor*)mostColor:(UIImage*)image imagesize:(CGSize)imageszie{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = imageszie;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                NSLog(@"x = %d , y = %d  , red = %d  alpha = %d ", x , y ,red  ,alpha);
            }else{
                
            }
            
            
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
