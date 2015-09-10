

//
//  PushViewController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "PushViewController.h"

@implementation PushViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bike_traveler"]];
    [self.view addSubview:imageV];
    imageV.frame = self.view.bounds;
    
    self.title = @"Push ViewController";
    
    UILabel *label = [UILabel new];
    int const labelW = 150;
    [self.view addSubview:label];
    label.frame = CGRectMake((CGRectGetMaxX(self.view.frame) - labelW) / 2, CGRectGetMaxY(self.view.frame) * 0.8, labelW, 50);
    label.text = @"Just do it ";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:18];
}
@end
