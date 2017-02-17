//
//  LoginRequest.m
//  ProjectTools
//
//  Created by Vols on 2017/1/26.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "LoginRequest.h"
#import "VHttpHelper.h"

@implementation LoginRequest

+ (void)login:(NSString *)mobile password:(NSString *)password result:(void(^)(BOOL flag))result {
    
    NSDictionary * parmas = @{@"mobile":mobile, @"password":password};
    
    [[VHttpHelper shared] post:parmas path:@"mobile/login" success:^(id flag) {
        
        NSDictionary *resultDic = (NSDictionary*)flag;
        
        if ([resultDic[@"IsSuccess"] boolValue]) {
            NSDictionary * userInfoDic = resultDic[@"Data"][@"DataInfo"];
            UserEntity * curUserModel = [[UserEntity alloc] initWithDictionary:userInfoDic];
            [DataCenter shared].host = curUserModel;    // 记录当前的用户
            result(YES);
        }
        else {
            result(NO);
            [[VHUDHelper shared] tipMessage:resultDic[@"MessageStr"]];
        }
        
    } failue:^(NSError *error) {
        result(NO);
    }];
}

+ (void)login:(LoginEntity *)param succ:(void(^)())succ fail:(void(^)(int code, NSString * msg))fail{
    
}

@end
