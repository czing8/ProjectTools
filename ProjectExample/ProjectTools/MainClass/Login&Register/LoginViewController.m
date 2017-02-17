//
//  LoginViewController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginEntity.h"
#import "LoginRequest.h"
#import "AppDelegate.h"

@interface LoginViewController () {
    LoginEntity *_loginParam;

}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([DataCenter shared].isAutoLogin) {
        [[DataCenter shared] loadFromLocal];
    }
    
//    [DataCenter configWith:_loginParam.config];
    
    if ([DataCenter shared].isAutoLogin && [[DataCenter shared].loginParam isValid]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self autoLogin];
        });
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self configureViews];
        });
    }
}

// 界面
- (void)configureViews {
    
}


- (void)autoLogin {
    if ([_loginParam isExpired]) {
        [[VHUDHelper shared] loading:@"刷新。。。"];

    }
    else {
        [self loginOperation];
    }
}



- (void)enterMainUI {
    [(AppDelegate *)[UIApplication sharedApplication].delegate enterMainUI];
    
//    [[DataCenter shared] configLoginSucc:_loginParam completion:nil];
}



- (void)loginOperation {
    //直接登录
    __weak LoginViewController *weakSelf = self;
    [[VHUDHelper shared] loading:@"正在登录"];
    
    [LoginRequest login:_loginParam succ:^{
        [[VHUDHelper shared] stopLoading:@"登录成功"];
        [weakSelf enterMainUI];

    } fail:^(int code, NSString *msg) {
        [[VHUDHelper shared] stopLoading:msg delay:2 completion:^{
            [weakSelf configureViews];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
