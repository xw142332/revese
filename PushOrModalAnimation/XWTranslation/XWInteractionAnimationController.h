//
//  InteractionAnimationController.h
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWConst.h"
@interface XWInteractionAnimationController : UIPercentDrivenInteractiveTransition
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, assign) BOOL transitionInProgress;
@property (nonatomic, assign) CGFloat completionSeed;
-(void)attachToViewController:(UIViewController *)viewController;
@end
