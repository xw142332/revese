//
//  NavigationAnimationController.h
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWNavigationAnimationController : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL reverse;
@property (nonatomic, assign) int dirction;
@end
