//
//  LogicHelper.m
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "DataCenter.h"

@interface DataCenter ()

@property (nonatomic, assign) VNetworkType networkType;

@end

@implementation DataCenter

#define kDataConfig             @"DataConfig"
#define kAutoLogin_Key          @"kAutoLogin_Key"



+ (instancetype)configWith:(DataConfig *)cfg {
    
    DataCenter * dataCenter = [self shared];
    [dataCenter config:cfg];
    return dataCenter;
}


+ (instancetype)shared {
    static dispatch_once_t predicate;
    static DataCenter *_sharedInstance = nil;

    dispatch_once(&predicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - login & Logout

- (void)login:(LoginEntity *)param succ:(SuccBlock)succ fail:(FailBlock)fail {
    if (!param) return;
    
    //处理登录逻辑
}

- (void)logout:(SuccBlock)succ fail:(FailBlock)fail {
    // 处理退出逻辑
    
}




- (void)changeToNetwork:(VNetworkType)work {
    if (work > kNetworkType_ReachableViaWWAN) {
        // 不处理这些
        work = kNetworkType_ReachableViaWWAN;
    }
    //    DebugLog(@"网络切换到(-1:未知 0:无网 1:wifi 2:移动网):%d", work);
    if (work != _networkType)  {
        self.networkType = work;
    }
}

//做具体的配置
- (void)config:(DataConfig *)cfg
{
//    比如一些第三方的配置
    
    
    
}


//- (DataConfig *)localConfig {
//    return _host.loginEntity.config;
//}

//- (void)configHost:(LoginEntity *)param completion:(void (^)())block {
//    if (!_host)  {
//        _host = [[HostEntity alloc] init];
//    }
//    _host.loginEntity = param;
//    [_host asyncProfile];
//
//}




- (void)configLoginSucc:(LoginEntity *)param completion:(void(^)())block {
    // 配置, 获取个人名片
//    [self configHost:param completion:block];
    
    // 获取好友列表
    //不能在登录成功之后获取好友里表，需要在OnProxyStatusChange回调成功的时候获取好友列表，否则可能获取不到
    // [self configContact];
    
    // 获取会话列表
    // [self configConversation];
    
#if kSupportAVChatRoom
    // 用户可结合自身逻辑，看是否处理退历史直播间消息
//    [self asyncExitHistoryAVChatRoom];
#endif
}


#pragma mark - setter/getter
- (BOOL)isAutoLogin {
    NSNumber *num = [[NSUserDefaults standardUserDefaults] objectForKey:kAutoLogin_Key];
    return [num boolValue];
}

- (void)setAutoLogin:(BOOL)autologin {
    [[NSUserDefaults standardUserDefaults] setObject:@(autologin) forKey:kAutoLogin_Key];
}



@end
