//
//  LogicHelper.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//  业务逻辑入口

#import <Foundation/Foundation.h>
#import "UserEntity.h"
#import "LoginEntity.h"
#import "DataConfig.h"


typedef void (^SuccBlock)();
typedef void (^FailBlock)(NSString * msg, NSUInteger code);

/**
 *  获取二进制
 */
typedef void (^GetResourceSucc)(NSData * data);

typedef NS_ENUM(NSInteger, VNetworkType) {
    kNetworkType_Undefine = -1,
    kNetworkType_NotReachable = 0,
    kNetworkType_ReachableViaWiFi = 1,
    kNetworkType_ReachableViaWWAN = 2,
};

@interface DataCenter : NSObject

@property (nonatomic, assign)   BOOL        isAutoLogin;    // 启动时是否自动登录
@property (nonatomic, assign)   BOOL        isConnected;
@property (nonatomic, readonly) VNetworkType networkType;

@property (nonatomic, strong) UserEntity  *host;           // 当前用户
@property (nonatomic, strong) LoginEntity *loginParam;     // 自动登录信息




+ (instancetype)shared;
+ (instancetype)configWith:(DataConfig *)cfg;


#pragma mark - login & Logout
- (void)login:(LoginEntity *)param succ:(SuccBlock)succ fail:(FailBlock)fail;
- (void)logout:(SuccBlock)succ fail:(FailBlock)fail;




- (DataConfig *)localConfig;


- (void)loadFromLocal;
- (void)saveToLocal;





// 初始化新增的缓存同步逻辑


// 被踢下线后，再重新登录
//- (void)offlineLogin;

//- (void)configHost:(LoginEntity *)param completion:(void(^)())block;

//- (void)changeToNetwork:(VNetworkType)work;



//- (void)configLoginSucc:(LoginEntity *)param completion:(void(^)())block;

@end
