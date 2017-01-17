//
//  LoginHandler.h
//  ProjectTools
//
//  Created by Vols on 2015/10/31.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHandler : NSObject

+ (void)login:(LoginEntity *)param succ:(void(^)())succ fail:(void(^)(int code, NSString * msg))fail;

// 配置进入主界面后的要拉取的数据
//+ (void)configOnLoginSucc:(LoginEntity *)param completion:(void(^)())block;

@end
