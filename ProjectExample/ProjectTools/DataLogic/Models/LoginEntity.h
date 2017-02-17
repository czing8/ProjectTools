//
//  LoginParam.h
//  HBDemo
//
//  Created by Vols on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataConfig.h"

/**
 *  登录前的处理，登录后的数据存到UserEntity中
 */
@interface LoginEntity : NSObject{

    NSString * _account;
    NSString * _password;
    BOOL     _rememberMe;
}

@property (nonatomic, strong) NSString * account;
@property (nonatomic, strong) NSString * password;

@property (nonatomic, assign) BOOL      rememberMe;      // 是否自动登录
@property (nonatomic, assign) NSInteger tokenTime;       // 时间戮



- (NSString *)checkLoginParma;
- (NSDictionary *)toParams;


//记录当前的account
+ (void)storeAccount:(NSString *)account;
+ (NSString *)storeAccount;

// 是否过期
- (BOOL)isExpired;

// 是否有效
- (BOOL)isValid;

/*
@property (nonatomic, strong) NSString  * accountType;    // 用户的账号类型
@property (nonatomic, strong) NSString  * identifier;     // 用户名

@property (nonatomic, strong) NSString  * userSig;        // 鉴权Token
@property (nonatomic, strong) NSString  * appidAt3rd;     // 用OAuth授权体系分配的Appid
@property (nonatomic, assign) int       sdkAppId;         // 用户标识接入SDK的应用ID

@property (nonatomic, assign) NSInteger tokenTime;      // 时间戮
@property (nonatomic, strong) DataConfig *config;       // 用户对应的配置


+ (instancetype)loadFromLocal;
- (void)saveToLocal;

// 是否过期
- (BOOL)isExpired;

// 是否有效
- (BOOL)isValid;
*/
@end
