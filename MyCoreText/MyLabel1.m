//
//  MyLabel1.m
//  MyCoreText
//
//  Created by 杜甲 on 2018/5/16.
//  Copyright © 2018年 杜甲. All rights reserved.
//

#import "MyLabel1.h"
#import <CoreText/CoreText.h>


@implementation MyLabel1

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
   
    // Drawing code
    CGContextRef conRef = UIGraphicsGetCurrentContext();
    //flip the coordinate system
    CGContextSetTextMatrix(conRef, CGAffineTransformIdentity);
    CGContextTranslateCTM(conRef, 0, self.bounds.size.height);
    CGContextScaleCTM(conRef, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();//1
    CGPathAddRect(path, NULL, self.bounds);
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:@" ิ"];//2  ， ？！ 。

    
    
    
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);//3
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
                                                CFRangeMake(0, attString.length),
                                                path,
                                                NULL);
    
    
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSLog(@"%@",lines);
    
    for (id lineObj in lines) { //5
        CTLineRef line = (__bridge CTLineRef)lineObj;
        for (id runObj in (NSArray *)CTLineGetGlyphRuns(line)) { //6
            
            CTRunRef run = (__bridge CTRunRef)runObj;
            CFRange runRange = CTRunGetStringRange(run);
            NSLog(@"runRange = %d  %d",runRange.length,runRange.location);
             //7
                CGRect runBounds;
                
            CGFloat ascent;//height above the baseline
            CGFloat descent;//height below the baseline
            
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL); //8
            runBounds.size.height = ascent + descent;
            
            NSLog(@"%@",NSStringFromCGRect(runBounds));
            
        }
    
    }
    
    CTFrameDraw(frame, conRef); //4
    
    CFRelease(framesetter); //5
    CFRelease(path);
    CFRelease(frame);

    
 
    
}


@end
