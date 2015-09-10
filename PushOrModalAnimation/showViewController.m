//
//  showViewController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "showViewController.h"

@implementation showViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bike_traveler"]];
    [self.view addSubview:imageV];
    imageV.frame = self.view.bounds;
    
    UIButton *disMissBtn = [[UIButton alloc]init];
    [disMissBtn setTitle:@"Dissmiss it " forState:UIControlStateNormal];
    int const buttonW = 150;
    [disMissBtn addTarget:self action:@selector(disMissBtnClick) forControlEvents:UIControlEventTouchUpInside];
    disMissBtn.frame = CGRectMake((CGRectGetMaxX(self.view.frame)  - buttonW) / 2, CGRectGetMaxY(self.view.frame) * 0.8, buttonW, buttonW);
    [self.view addSubview:disMissBtn];
}
-(void)disMissBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
