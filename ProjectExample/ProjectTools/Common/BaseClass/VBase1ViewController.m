//
//  VBase1ViewController.m
//  PrejectTools
//
//  Created by Vols on 2016/10/25.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VBase1ViewController.h"

@interface VBase1ViewController ()

@end

@implementation VBase1ViewController

#pragma mark - View Lifecycle

- (void)dealloc {
    NSLog(@"%@ ---> release释放成功", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGB(250, 250, 250);
    
    [self configureNavController];
    [self initData];
    [self configureViews];
}


- (void)initData {
    
    
}


- (void)configureViews {
    
}


- (void)configureNavController {
    self.navigationItem.titleView = self.titleLabel;
    self.edgesForExtendedLayout = UIRectEdgeNone;       // 原点坐标从导航栏下边计算
    
    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
//    self.navigationController.navigationBar.barTintColor = kRGB(248, 248, 248);
    
    //防止跳转时，导航栏右上角出现黑块。
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - properties

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        _titleLabel.textColor = kRGB(51, 51, 51);
        _titleLabel.textColor = self.navigationController.navigationBar.tintColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - hepler

- (void)setLeftBarButtonWithImage:(NSString *)imageStr {
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(10, 10, 24, 24)];
    [leftBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

- (void)setRightBarButtonWithImage:(NSString *)imageStr{
    UIButton *rightI=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightI setFrame:CGRectMake(310-24, 10, 24, 24)];
    [rightI setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [rightI addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    rightI.showsTouchWhenHighlighted=YES;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightI];
}


#pragma mark - actions

- (void)leftBarButtonClicked:(UIButton *)button{
    
}

- (void)rightBarButtonClicked:(UIButton *)button{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
