//
//  InteractionAnimationController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "XWInteractionAnimationController.h"

@implementation XWInteractionAnimationController

-(CGFloat)completionSeed{
    return 1 - self.percentComplete;
}

-(void)attachToViewController:(UIViewController *)viewController{
    self.navigationController = viewController.navigationController;
    [self setupGestureRecognizer:viewController.view];
}
-(void)setupGestureRecognizer:(UIView *)view{
    view.userInteractionEnabled = true;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [view addGestureRecognizer:pan];
    
}
-(void)handlePanGesture:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint viewTranslation = [gestureRecognizer translationInView:gestureRecognizer.view.superview];
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.transitionInProgress = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:{
            CGFloat constant = fminf(fmaxf(viewTranslation.x/ 2.0, 0.0), 1.0);
            self.shouldCompleteTransition = constant > 0.5;
            [self updateInteractiveTransition:constant];
            
        }
            break;
        case UIGestureRecognizerStateCancelled:
             UIGestureRecognizerStateEnded:
            self.transitionInProgress = NO;
            if (!self.shouldCompleteTransition || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }else{
                [self finishInteractiveTransition];
            }
            break;
            
        default:
            NSLog(@"This is default");
            break;
    }
}
@end
