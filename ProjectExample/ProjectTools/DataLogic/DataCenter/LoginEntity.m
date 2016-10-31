//
//  LoginParam.m
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "LoginEntity.h"
#import "NSString+VAdd.h"

#define kDaysInSeconds(x)           (x * 24 * 60 * 60)
#define kLoginParamUserKey       @"kLoginParamUserKey"

@implementation LoginEntity

- (instancetype)init {
    if (self = [super init]) {
//        self.appidAt3rd = kSdkAppId;
//        self.sdkAppId = [kSdkAppId intValue];
//        self.accountType = kSdkAccountType;
//        self.config = [[IMAPlatformConfig alloc] init];
    }
    return self;
}


+ (instancetype)loadFromLocal {
//    NSString *userloginKey = [[NSUserDefaults standardUserDefaults] objectForKey:kLoginParamUserKey];
//    if (userloginKey) {
//        // 说明本地有存储
//        LoginEntity *param = [LoginEntity loadInfo:[LoginEntity class] withKey:userloginKey];
//        return param;
//    }
//    else {
//        return [[LoginEntity alloc] init];
//    }
    return nil;
}


- (BOOL)isExpired {
    time_t curTime = [[NSDate date] timeIntervalSince1970];
    BOOL expired = curTime - self.tokenTime > kDaysInSeconds(10);
    return expired;
}

- (BOOL)isValid {
    return ![NSString isEmpty:self.identifier] && ![NSString isEmpty:self.userSig] && ![self isExpired];
}

@end
