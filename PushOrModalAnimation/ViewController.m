//
//  ViewController.m
//  PushOrModalAnimation
//
//  Created by mac on 15/9/9.
//  Copyright © 2015年 肖伟. All rights reserved.
//

#import "ViewController.h"
#import "XWPresentAnimationViewController.h"
#import "XWDismissAnimationController.h"
#import "XWNavigationAnimationController.h"
#import "XWInteractionAnimationController.h"
#import "PushLeftViewController.h"

#import "showViewController.h"
#import "PushViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XWPresentAnimationViewController *XWPresentAnimationViewController;
@property (nonatomic, strong) XWDismissAnimationController *dismissAnimationViewController;
@property (nonatomic, strong) XWNavigationAnimationController *navigationAnimationController;
@property (nonatomic, strong) XWInteractionAnimationController *ineractionAnimationController;

@property (nonatomic, assign) BOOL isLeftItem;
@end
NSString * const reusedCell = @"Cell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Main";
//    [self.view setBackgroundColor:[UIColor redColor]];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"Click me" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"left Item Click" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarClick)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.XWPresentAnimationViewController = [[XWPresentAnimationViewController alloc]init];
    self.dismissAnimationViewController = [[XWDismissAnimationController alloc]init];
    self.navigationAnimationController = [[XWNavigationAnimationController alloc]init];
    self.navigationAnimationController.dirction = -1;
    self.ineractionAnimationController = [[XWInteractionAnimationController alloc]init];
    
    self.navigationController.delegate = self;
}

#pragma mark - Actions
-(void)rightBarClick{
    showViewController *showVc = [[showViewController alloc]init];
    showVc.transitioningDelegate = self;
    [self presentViewController:showVc animated:YES completion:nil];
}
-(void)leftBarClick{
    PushLeftViewController *leftVc = [[PushLeftViewController alloc]init];
    leftVc.transitioningDelegate = self;
    self.isLeftItem = YES;
    [self.navigationController pushViewController:leftVc animated:YES];
}
#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusedCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"永远不要去测量山的高度,除非你已经到达山顶 .到那时，所谓的高不可攀就会消失地无影无踪"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.alpha = 0.0;
    cell.backgroundColor = [UIColor orangeColor];
    [UIView animateWithDuration:0.8 animations:^{
        cell.alpha = 1.0;
        cell.backgroundColor = [UIColor whiteColor];
    }];
}
#pragma mark - UIViewControllerTransitioningDelegate
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.XWPresentAnimationViewController;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self.dismissAnimationViewController;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PushViewController *pushVc = [[PushViewController alloc]init];
    self.isLeftItem = NO;
    [self.navigationController pushViewController:pushVc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush) {
        [self.ineractionAnimationController attachToViewController:toVC];
        self.navigationAnimationController.dirction = self.isLeftItem? 1 : -1;
    }
    
    self.navigationAnimationController.reverse = operation == UINavigationControllerOperationPop;
    return self.navigationAnimationController;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
