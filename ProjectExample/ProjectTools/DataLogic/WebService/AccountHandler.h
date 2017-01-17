//
//  AccountHandler.h
//  ProjectTools
//
//  Created by Vols on 2016/11/23.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VHttpHelper.h"
#import "UserEntity.h"

@interface AccountHandler : NSObject

+ (void)editUserInfo:(NSString *)uid key:(NSString *)key value:(NSString *)value type:(NSUInteger)type result:(void(^)(BOOL flag))result;


/*
 *  处理数据，直接返回 model
 */
+ (void)getUserInfo:(NSString *)uid result:(void(^)(UserEntity *userEntity, BOOL flag))result;


@end
