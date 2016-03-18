//
//  VBaseViewController.m
//  SQFunbox
//
//  Created by Vols on 15/2/13.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VBaseViewController.h"

@interface VBaseViewController ()

@end

@implementation VBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGB(250, 250, 250);
    
    [self initNavControllerBar];
}

- (void)initNavControllerBar{
    self.navigationItem.titleView = self.titleLabel;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = kRGB(248, 248, 248);
}

#pragma mark - properties

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = kRGB(51, 51, 51);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UILabel *)errorLabel{
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kSCREEN_SIZE.width, 30)];
        _errorLabel.backgroundColor = [UIColor clearColor];
        _errorLabel.font = [UIFont systemFontOfSize:16];
        _errorLabel.textColor = kRGB(51, 51, 51);
        _errorLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _errorLabel;
}

- (void)setNavBackBarButton{
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10, 10, 24, 24);
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}


#pragma mark - hepler

-(void)setLeftBarButtonWithImage:(NSString *)imageStr{
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(10, 10, 24, 24)];
    [leftBtn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.showsTouchWhenHighlighted = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

-(void)setRightBarButtonWithImage:(NSString *)imageStr{
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


- (void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
