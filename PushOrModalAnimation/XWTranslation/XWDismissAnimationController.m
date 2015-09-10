//
//  DismissAnimationController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "XWDismissAnimationController.h"

@implementation XWDismissAnimationController
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return dismissAnimationDuration;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = finalFrameForVc;
    toViewController.view.alpha = 0.5;
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    
    //Explain:因为view缩小 并不会缩小里面的image 所以使用 snapshotView 来解决问题
    UIView *snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:false];
    snapshotView.frame = fromViewController.view.frame;
    [containerView addSubview:snapshotView];
    [fromViewController.view removeFromSuperview];
    
    //start Animation
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.alpha = 1.0;
        snapshotView.frame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 2, fromViewController.view.frame.size.height / 2);
    }completion:^(BOOL finished) {
        [snapshotView removeFromSuperview];
        [transitionContext completeTransition:true];
    }];
}
@end
