//
//  LogicHelper.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HostEntity.h"
#import "DataConfig.h"


/**
 *  一般操作成功回调
 */
typedef void (^Succ)();

/**
 *  操作失败回调
 *
 *  @param code 错误码
 *  @param msg  错误描述，配合错误码使用，如果问题建议打印信息定位
 */
typedef void (^Fail)(int code, NSString * msg);

/**
 *  登陆成功回调
 */
typedef void (^LoginSucc)();

/**
 *  获取资源
 *
 *  NSData 资源二进制
 */
typedef void (^TIMGetResourceSucc)(NSData * data);

typedef NS_ENUM(NSInteger, VNetworkType) {
    kNetworkType_Undefine = -1,
    kNetworkType_NotReachable = 0,
    kNetworkType_ReachableViaWiFi = 1,
    kNetworkType_ReachableViaWWAN = 2,
};

// 业务逻辑入口
@interface DataCenter : NSObject

@property (nonatomic, readonly) HostEntity  *host;    // 当前用户
@property (nonatomic, assign)   BOOL        isConnected;     // 当前是否连接上，外部可用此方法判断是否有网

// 当前使用的网络类型，默认wifi，只取VNetworkType 中对应的 -1:未知 0:无网 1:wifi 2:移动网，用户若需要，可重写对应的方法以满足自身App需求
@property (nonatomic, readonly) VNetworkType networkType;


@property (nonatomic, assign)   BOOL        isAutoLogin;     // 是否自动登录


+ (instancetype)configWith:(DataConfig *)cfg;

+ (instancetype)shared;


- (DataConfig *)localConfig;

- (void)saveToLocal;

// 初始化新增的缓存同步逻辑

// 退出
- (void)logout:(LoginSucc)succ fail:(Fail)fail;

// 被踢下线后，再重新登录
- (void)offlineLogin;

- (void)configHost:(LoginEntity *)param completion:(void(^)())block;

- (void)changeToNetwork:(VNetworkType)work;



- (void)configLoginSucc:(LoginEntity *)param completion:(void(^)())block;

@end
