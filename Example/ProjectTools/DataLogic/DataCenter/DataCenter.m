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


static DataCenter *_sharedInstance = nil;

+ (instancetype)configWith:(DataConfig *)cfg
{
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        _sharedInstance = [[self alloc] init];
        [_sharedInstance config:cfg];
    });
    
    return _sharedInstance;
    
}


+ (instancetype)sharedInstance
{
    // TODO:
    return _sharedInstance;
}


+ (BOOL)isAutoLogin {
    NSNumber *num = [[NSUserDefaults standardUserDefaults] objectForKey:kAutoLogin_Key];
    return [num boolValue];
}

+ (void)setAutoLogin:(BOOL)autologin {
    [[NSUserDefaults standardUserDefaults] setObject:@(autologin) forKey:kAutoLogin_Key];
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


- (DataConfig *)localConfig {
    return _host.loginEntity.config;
}

- (void)configHost:(LoginEntity *)param completion:(void (^)())block {
    if (!_host)  {
        _host = [[HostEntity alloc] init];
    }
    _host.loginEntity = param;
    [_host asyncProfile];

}






@end
