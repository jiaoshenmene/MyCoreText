//
//  MyView.m
//  MyCoreText
//
//  Created by 杜甲 on 2018/5/25.
//  Copyright © 2018年 杜甲. All rights reserved.
//

#import "MyView.h"
#import <CoreText/CoreText.h>
@implementation MyView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:self.text];//2  ， ？！ 。   ิ124。
    
    
    [attString addAttributes:@{NSFontAttributeName : self.font } range:NSMakeRange(0, attString.length)];
    
    
    CGRect rect1 = [attString boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesDeviceMetrics context:nil];
    NSLog(@"rect1 = %@",NSStringFromCGRect(rect1));
    
    
    
    NSString *text = self.text;//@"devZhang is an iOS developer.iOS开发者 iOS开发者 iOS开发者 iOS开发者 iOS开发者";
    // 文本段落样式
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
    textStyle.lineBreakMode = NSLineBreakByWordWrapping; // 结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    textStyle.alignment = NSTextAlignmentLeft; //（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    textStyle.lineSpacing = 0; // 字体的行间距
    textStyle.firstLineHeadIndent = 0; // 首行缩进
    textStyle.headIndent = 0.0; // 整体缩进(首行除外)
    textStyle.tailIndent = 0.0; //
    textStyle.minimumLineHeight = 0; // 最低行高
    textStyle.maximumLineHeight = rect.size.height; // 最大行高
    textStyle.paragraphSpacing = 15; // 段与段之间的间距
//    textStyle.paragraphSpacingBefore = 22.0f; // 段首行空白空间/* Distance between the bottom of the previous paragraph (or the end of its paragraphSpacing, if any) and the top of this paragraph. */
    textStyle.baseWritingDirection = NSWritingDirectionLeftToRight; // 从左到右的书写方向（一共➡️三种）
    textStyle.lineHeightMultiple = 15; /* Natural line height is multiplied by this factor (if positive) before being constrained by minimum and maximum line height. */
    textStyle.hyphenationFactor = 1; //连字属性 在iOS，唯一支持的值分别为0和1
    // 文本属性
    NSMutableDictionary *textAttributes = [[NSMutableDictionary alloc] init];
    // NSParagraphStyleAttributeName 段落样式
    [textAttributes setValue:textStyle forKey:NSParagraphStyleAttributeName];
    // NSFontAttributeName 字体名称和大小
    [textAttributes setValue:self.font forKey:NSFontAttributeName];
    // NSForegroundColorAttributeNam 颜色
    [textAttributes setValue:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    // 绘制文字
    
    
    
    CGRect r1 = CGRectMake(- rect1.origin.x , rect.origin.y, ceil(rect1.size.width) , rect.size.height);
    
    NSLog(@"%@",NSStringFromCGRect(rect));
    NSLog(@"%@",NSStringFromCGRect(r1));
    [text drawInRect:r1 withAttributes:textAttributes];
    
    
    
    // Drawing code
    // Drawing code
//    CGContextRef conRef = UIGraphicsGetCurrentContext();
//    //flip the coordinate system
//    CGContextSetTextMatrix(conRef, CGAffineTransformIdentity);
//    CGContextTranslateCTM(conRef, 0, self.bounds.size.height);
//    CGContextScaleCTM(conRef, 1.0, -1.0);
//
//    CGMutablePathRef path = CGPathCreateMutable();//1
//    CGPathAddRect(path, NULL, self.bounds);
//    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:self.text];//2  ， ？！ 。
//
//
//    [attString addAttributes:@{NSFontAttributeName : self.font} range:NSMakeRange(0, attString.length)];
//
//
//    CGRect rect1 = [attString boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesDeviceMetrics context:nil];
//    NSLog(@"rect1 = %@",NSStringFromCGRect(rect1));
//
//    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);//3
//    CTFrameRef frame = CTFramesetterCreateFrame(framesetter,
//                                                CFRangeMake(0, attString.length),
//                                                path,
//                                                NULL);
//
//
//    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
//    NSLog(@"%@",lines);
//
//    for (id lineObj in lines) { //5
//        CTLineRef line = (__bridge CTLineRef)lineObj;
//        for (id runObj in (NSArray *)CTLineGetGlyphRuns(line)) { //6
//
//            CTRunRef run = (__bridge CTRunRef)runObj;
//            CFRange runRange = CTRunGetStringRange(run);
//            NSLog(@"runRange = %d  %d",runRange.length,runRange.location);
//            //7
//            CGRect runBounds;
//
//            CGFloat ascent;//height above the baseline
//            CGFloat descent;//height below the baseline
//
//            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL); //8
//            runBounds.size.height = ascent + descent;
//
//            NSLog(@"%@",NSStringFromCGRect(runBounds));
//
//        }
//
//    }
//
//    CTFrameDraw(frame, conRef); //4
//
//    CFRelease(framesetter); //5
//    CFRelease(path);
//    CFRelease(frame);
    
}


@end
