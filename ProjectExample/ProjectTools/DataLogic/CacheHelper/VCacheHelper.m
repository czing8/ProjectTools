//
//  VCacheManager.m
//  CacheManagerDemo
//
//  Created by Vols on 15/4/15.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VCacheHelper.h"

@implementation VCacheHelper


+ (void)saveCache:(id)cache key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:cache forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


+ (BOOL)hasCache:(NSString *)key{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] != nil) {
        return YES;
    }
    else{
        return NO;
    }
}


+ (id)getCache:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
