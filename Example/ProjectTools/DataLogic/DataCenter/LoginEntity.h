//
//  LoginParam.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataConfig.h"

/**
 *  登陆信息
 */
@interface LoginEntity : NSObject{
    NSString*       _accountType;        // 用户的账号类型
    NSString*       _identifier;         // 用户名
    
    NSString*       _userSig;            // 鉴权Token
    NSString*       _appidAt3rd;         // 用OAuth授权体系分配的Appidß
    int             _sdkAppId;           // 用户标识接入SDK的应用ID
}

@property (nonatomic, strong) NSString* accountType;
@property (nonatomic, strong) NSString* identifier;
@property (nonatomic, strong) NSString* userSig;
@property (nonatomic, strong) NSString* appidAt3rd;
@property (nonatomic, assign) int sdkAppId;

@property (nonatomic, assign) NSInteger tokenTime;        // 时间戮
@property (nonatomic, strong) DataConfig *config;        // 用户对应的配置

+ (instancetype)loadFromLocal;

- (void)saveToLocal;

// 是否过期
- (BOOL)isExpired;

// 是否有效
- (BOOL)isVailed;

@end
