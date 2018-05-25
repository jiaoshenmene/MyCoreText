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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MyLabel1 *label = [[MyLabel1 alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.font = [UIFont systemFontOfSize:22];
//    label.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:label];
    
    
    NSMutableAttributedString* attString = [[NSMutableAttributedString alloc] initWithString:@" ົ"];//2  ， ？！ 。   ิ124。
    
    
    [attString addAttributes:@{NSFontAttributeName : label.font } range:NSMakeRange(0, attString.length)];
    
    
    CGRect rect1 = [attString boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesDeviceMetrics context:nil];
    NSLog(@"rect1 = %@",NSStringFromCGRect(rect1));
    
    
    UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 100)];
    [self.view addSubview:v1];
    v1.backgroundColor = [UIColor redColor];
    
    UIView *l2 = [[UIView alloc] initWithFrame:rect1];
    l2.backgroundColor = [UIColor greenColor];
    l2.center = CGPointMake(v1.center.x, v1.center.y);
    [self.view addSubview:l2];
    
    MyView *l1 = [[MyView alloc] initWithFrame:CGRectMake(( CGRectGetWidth(v1.frame) - ceil(rect1.size.width)  ) / 2 , 0,  ceil(rect1.size.width ) + 50, 100)];
    l1.text = attString.string;
    
    l1.font = label.font;
    l1.backgroundColor = [UIColor grayColor];
    l1.alpha = 0.5f;
    [v1 addSubview:l1];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
