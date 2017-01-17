//
//  AccountHandler.m
//  ProjectTools
//
//  Created by Vols on 2015/11/23.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "AccountHandler.h"

@implementation AccountHandler


+ (void)editUserInfo:(NSString *)uid key:(NSString *)key value:(NSString *)value type:(NSUInteger)type result:(void(^)(BOOL flag))result{
    
    NSDictionary * parmas = @{@"uid":uid, key:value, @"itype":@(type)};
    
    [[VHttpHelper shared] post:parmas path:@"http://vd.***.com.cn/Mobile/EditUder" success:^(id flag) {
        
        NSDictionary *resultDic = (NSDictionary*)flag;
        
        if ([resultDic[@"IsSuccess"] boolValue]) {
            [[VHUDHelper shared] tipMessage:resultDic[@"MessageStr"]];
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


+ (void)getUserInfo:(NSString *)uid result:(void(^)(UserEntity *userModel, BOOL flag))result {
    
    NSDictionary * parmas = @{@"uid":uid};
    
    [[VHttpHelper shared] post:parmas path:@"http://vd.***.com.cn/Mobile/UserGetUid" success:^(id flag) {
        
        NSLog(@"UserInfo --> %@", flag);
        NSDictionary *resultDic = (NSDictionary*)flag;
        
        if ([resultDic[@"IsSuccess"] boolValue]) {
            NSDictionary * userInfoDic = resultDic[@"Data"][@"DataInfo"];
            UserEntity * curUserModel = [[UserEntity alloc] initWithDictionary:userInfoDic];
            result(curUserModel, YES);
        }
        else {
            result(nil, NO);
            [[VHUDHelper shared] tipMessage:resultDic[@"MessageStr"]];
        }
        
    } failue:^(NSError *error) {
        
    }];
}



@end
