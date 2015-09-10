//
//  PresentAnimationViewController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "XWPresentAnimationViewController.h"

@implementation XWPresentAnimationViewController : NSObject
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return presentAnimationDuration;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toViewController];
    UIView *containerView = [transitionContext containerView];
    CGRect bounds = [UIScreen mainScreen].bounds;
    //Explain:先让toViewController 偏移
    toViewController.view.frame = CGRectOffset(finalFrameForVc, 0, -bounds.size.height);
    [containerView addSubview:toViewController.view];
    //animation now
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        fromViewController.view.alpha = 0.5;
        toViewController.view.frame = finalFrameForVc;
    } completion:^(BOOL finished) {
        fromViewController.view.alpha = 1.0;
        [transitionContext completeTransition:YES];
    }];
}
@end
