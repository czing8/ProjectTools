//
//  LoginViewController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginEntity.h"
#import "LoginRegisterRequest.h"
#import "AppDelegate.h"

@interface LoginViewController ()
{
    LoginEntity               *_loginParam;

}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([DataCenter shared].isAutoLogin) {
        _loginParam = [LoginEntity loadFromLocal];
    }else{
        _loginParam = [[LoginEntity alloc] init];
    }
    
    [DataCenter configWith:_loginParam.config];
    
    if ([DataCenter shared].isAutoLogin && [_loginParam isValid]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self autoLogin];
        });
    }
    else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self displayUIs];
        });
    }
}



- (void)displayUIs {
    //界面
}


- (void)autoLogin {
    if ([_loginParam isExpired]) {
        [[VHUDHelper shared] show:@"刷新票据。。。"];
        //刷新票据
        //        [[TLSHelper getInstance] TLSRefreshTicket:_loginParam.identifier andTLSRefreshTicketListener:self];
    }
    else {
        [self loginOperation];
    }
}



- (void)enterMainUI {
    [(AppDelegate *)[UIApplication sharedApplication].delegate enterMainUI];
    
    [[DataCenter shared] configLoginSucc:_loginParam completion:nil];
}



- (void)loginOperation {
    //直接登录
    __weak LoginViewController *weakSelf = self;
    [[VHUDHelper shared] show:@"正在登录"];
    
    [LoginRegisterRequest login:_loginParam succ:^{
        [[VHUDHelper shared] hideHUDMessage:@"登录成功"];
        [weakSelf enterMainUI];

    } fail:^(int code, NSString *msg) {
        [[VHUDHelper shared] hideHUDMessage:msg delay:2 completion:^{
            [weakSelf displayUIs];
        }];
    }];
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
