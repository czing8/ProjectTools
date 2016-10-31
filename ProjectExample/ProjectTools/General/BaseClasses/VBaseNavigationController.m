//
//  VBaseNavigationController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VBaseNavigationController.h"

@interface VBaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation VBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGestureRecognizer];
    self.interactivePopGestureRecognizer.delegate = self;
}

#pragma mark - private method
- (void)setUpGestureRecognizer
{
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self;
    [self.view addGestureRecognizer:panGesture];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (void)handleNavigationTransition:(UIGestureRecognizer *)gestureRecognizer
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.childViewControllers.count == 1) {
        //在根控制器界面，不触发滑动手势。
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
