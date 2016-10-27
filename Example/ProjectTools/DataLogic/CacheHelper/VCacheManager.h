//
//  VCacheManager.h
//  CacheManagerDemo
//
//  Created by Vols on 15/4/15.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCacheManager : NSObject

+ (void)saveCache:(id)cache key:(NSString *)key;
+ (BOOL)hasCache:(NSString *)key;
+ (id)getCache:(NSString *)key;

@end
