//
//  LoginParam.m
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "LoginEntity.h"
#import "NSString+Extension.h"

#define kDaysInSeconds(x)           (x * 24 * 60 * 60)

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




- (BOOL)isExpired
{
    time_t curTime = [[NSDate date] timeIntervalSince1970];
    BOOL expired = curTime - self.tokenTime > kDaysInSeconds(10);
    return expired;
}

- (BOOL)isVailed
{
    return ![NSString isEmpty:self.identifier] && ![NSString isEmpty:self.userSig] && ![self isExpired];
}

@end
