//
//  LoginRequest.h
//  ProjectTools
//
//  Created by Vols on 2017/1/26.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject

+ (void)login:(NSString *)mobile password:(NSString *)password result:(void(^)(BOOL flag))result;

+ (void)login:(LoginEntity *)param succ:(void(^)())succ fail:(void(^)(int code, NSString * msg))fail;

@end
