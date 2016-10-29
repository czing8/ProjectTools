//
//  HSKeyChain.h
//  QQ_music
//
//  Created by 李松 on 16/3/11.
//  Copyright © 2016年 lisong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;

@end
