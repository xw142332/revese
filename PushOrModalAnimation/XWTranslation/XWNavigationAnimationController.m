
//
//  NavigationAnimationController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "XWNavigationAnimationController.h"
@interface XWNavigationAnimationController()
@end

@implementation XWNavigationAnimationController

#pragma mark - UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.5;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
//    self.reverse = false;
    
    UIView *containerView = [transitionContext containerView];
   
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = toViewController.view;
    UIView *fromView = fromViewController.view;
    
    CGFloat diraction = self.reverse ? self.dirction : -self.dirction;
    
    CGFloat constant = -0.005;
    
    toView.layer.anchorPoint = CGPointMake(diraction == 1? 0 : 1, 0.5);
    fromView.layer.anchorPoint = CGPointMake(diraction == 1? 1 : 0, 0.5);

    CATransform3D viewFromTransform = CATransform3DMakeRotation(diraction * M_PI_2, 0.0, 1.0, 0.0);
    CATransform3D viewToTransform = CATransform3DMakeRotation(-diraction * M_PI_2, 0.0, 1.0, 0.0);
    
    viewToTransform.m34 = constant;
    viewFromTransform.m34 = constant;
    
    
    containerView.transform = CGAffineTransformMakeTranslation(diraction * containerView.frame.size.width / 2.0, 0);
    toView.layer.transform = viewToTransform;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        containerView.transform = CGAffineTransformMakeTranslation(-diraction * containerView.frame.size.width / 2.0, 0);
        fromView.layer.transform = viewFromTransform;
        toView.layer.transform = CATransform3DIdentity;
    }completion:^(BOOL finished) {
        containerView.transform = CGAffineTransformIdentity;
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        }else{
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}
#pragma mark - lazyloading

@end
