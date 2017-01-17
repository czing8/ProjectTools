//
//  VCacheManager.h
//  CacheManagerDemo
//
//  Created by Vols on 15/4/15.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

// ================ Vols ==================
/*
 *  仿SDImageCache实现，读写操作都在异步线程中执行
 *  待完善
 */
// ========================================
#import <Foundation/Foundation.h>

@interface VCacheHelper : NSObject

@property (assign, nonatomic) NSInteger     maxCacheAge;
@property (assign, nonatomic) NSUInteger    maxCacheSize;

+ (VCacheHelper *)sharedCache;



/*
 *  获取Cache文件夹全部内容大小，包括了SDWebImage的缓存
 */
- (NSString *)sizeOfALLDiskCache;


/*
 *  删除所有的磁盘缓存，清空Cache文件
 */
- (void)clearAllDiskCache;
- (void)clearAllDiskCacheOnCompletion:(void(^)())completion;


@end
