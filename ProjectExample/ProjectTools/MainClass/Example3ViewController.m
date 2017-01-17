//
//  Example3ViewController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "Example3ViewController.h"
#import "V2ShowWebViewController.h"

@interface Example3ViewController ()

@property (nonatomic, strong) UIButton *testBtn;

@end

@implementation Example3ViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self configureViews];
    
}

- (void)initData {
    
}

- (void)configureViews {
    self.view.backgroundColor = [UIColor randomColor];
    [self.view addSubview:self.testBtn];
    
}

#pragma mark - Actions

- (void)clickAction:(UIButton *)button {
    V2ShowWebViewController *webView = [[V2ShowWebViewController alloc] init];
    [webView loadWebURLSring:@"http://www.sina.com"];
    webView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webView animated:YES];
}

#pragma mark - Properties

- (UIButton *)testBtn {
    if (_testBtn == nil) {
        _testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _testBtn.frame  = CGRectMake(0, 0, 80, 40);
        _testBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
        _testBtn.backgroundColor = [UIColor purpleColor];
        [_testBtn setTitle:@"click" forState:UIControlStateNormal];
        [_testBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _testBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _testBtn.layer.cornerRadius = 3.0;
        [_testBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _testBtn;
}



#pragma mark - Helpers

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
