

//
//  PushLeftViewController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/10.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "PushLeftViewController.h"

@implementation PushLeftViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"鬼谷子";
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    label.frame = self.view.bounds;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:120];
    label.text = @"鬼谷子";
    label.backgroundColor = [UIColor orangeColor];
    
    
}
@end
