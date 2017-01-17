//
//  LoginParam.m
//  HBDemo
//
//  Created by Vols on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "LoginEntity.h"
#import "NSString+VAdd.h"
#import "NSObject+VAdd.h"
#import "JSONHelper.h"

#define kDaysInSeconds(x)           (x * 24 * 60 * 60)
#define kLoginParamUserKey       @"kLoginParamUserKey"


#define kLoginAccount           @"kLoginAccount"


@implementation LoginEntity

- (instancetype)init {
    if (self = [super init]) {
        self.rememberMe = [NSNumber numberWithBool:YES];
        self.account = @"";
        self.password = @"";
        
//        self.appidAt3rd = kSdkAppId;
//        self.sdkAppId = [kSdkAppId intValue];
//        self.accountType = kSdkAccountType;
//        self.config = [[IMAPlatformConfig alloc] init];
    }
    return self;
}


- (NSString *)checkLoginParma {
    if (!_account || _account.length <= 0) {
        return @"请填写「手机号码/电子邮箱/个性后缀」";
    }
    if (!_password || _password.length <= 0) {
        return @"请填写密码";
    }
    return nil;
}


- (NSDictionary *)toParams{
    NSMutableDictionary *params = @{@"account": self.account,
                                    @"password" : [self.password md5],
                                    @"remember_me" : self.rememberMe ? @"true" : @"false"}.mutableCopy;
    return params;
}



+ (void)storeAccount:(NSString *)account {
    if (account.length <= 0) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:account forKey:@"login_account"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)storeAccount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"login_account"];
}


#pragma mark - getter/setter

- (void)setRememberMe:(BOOL)rememberMe {
    _rememberMe = rememberMe;
    [[NSUserDefaults standardUserDefaults] setBool:rememberMe forKey:@"login_rememberMe"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)rememberMe {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"login_rememberMe"];
}

/*
+ (instancetype)loadFromLocal {
    NSString *userloginKey = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginParamUserKey];
    NSString *loginInfo = nil;
    
    if (userloginKey) {
        loginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:userloginKey];
    }
    
    if (loginInfo) {
        NSDictionary * loginDic = [loginInfo objectFromJSONString];
        LoginEntity *param = [LoginEntity parse:[LoginEntity class] dictionary:loginDic];
        return param;
    }
    else  {
        return [[LoginEntity alloc] init];
    }
}


- (void)saveToLocal {
    if (self.tokenTime == 0) {
        self.tokenTime = [[NSDate date] timeIntervalSince1970];
    }
    
    if ([self isValid]) {
        NSString *userloginKey = [NSString stringWithFormat:@"%@_LoginParam", self.identifier];
        [[NSUserDefaults standardUserDefaults] setObject:userloginKey forKey:kLoginParamUserKey];
        [LoginEntity saveInfo:self withKey:userloginKey];
    }
}


- (BOOL)isExpired {
    time_t curTime = [[NSDate date] timeIntervalSince1970];
    BOOL expired = curTime - self.tokenTime > kDaysInSeconds(10);
    return expired;
}

- (BOOL)isValid {
    return ![NSString isEmpty:self.identifier] && ![NSString isEmpty:self.userSig] && ![self isExpired];
}
*/


@end
