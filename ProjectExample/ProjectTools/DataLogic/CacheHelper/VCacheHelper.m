//
//  VCacheManager.m
//  CacheManagerDemo
//
//  Created by Vols on 15/4/15.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VCacheHelper.h"

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week

@interface VCacheHelper ()

@property (strong, nonatomic) dispatch_queue_t ioQueue;
@property (strong, nonatomic) NSString *diskCachePath;          //默认缓存路径

@end

@implementation VCacheHelper {
    NSFileManager *_fileManager;
}


+ (VCacheHelper *)sharedCache {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}


- (id)init {
    return [self initWithNamespace:@"default"];
}

- (id)initWithNamespace:(NSString *)ns {
    NSString *path = [self makeDiskCachePath:ns];
    return [self initWithNamespace:ns diskCacheDirectory:path];
}


- (id)initWithNamespace:(NSString *)ns diskCacheDirectory:(NSString *)directory {
    if ((self = [super init])) {
        
        NSString *fullNamespace = [@"com.vols.Cache." stringByAppendingString:ns];
        
        _ioQueue = dispatch_queue_create("com.vols.Cache", DISPATCH_QUEUE_SERIAL);
        
        _maxCacheAge = kDefaultCacheMaxCacheAge;
        
        if (directory != nil) {
            _diskCachePath = [directory stringByAppendingPathComponent:fullNamespace];
        } else {
            NSString *path = [self makeDiskCachePath:ns];
            _diskCachePath = path;
        }
        
        dispatch_sync(_ioQueue, ^{
            _fileManager = [NSFileManager new];
        });
    }
    return self;
}

- (NSString *)makeDiskCachePath:(NSString*)fullNamespace{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [paths[0] stringByAppendingPathComponent:fullNamespace];
}



- (void)storeImageDataToDisk:(NSData *)imageData forKey:(NSString *)key {
    
    
}

#pragma mark -  清空初始化时指定缓存目录，非整个Cache目录
/*
 *  清空初始化时指定缓存目录，非整个Cache目录
 */
 - (void)clearDiskCache {
    [self clearDiskCacheOnCompletion:nil];
}

/*
 *  清空初始化时指定缓存目录，非整个Cache目录,整个删掉目录在创建。
 */
- (void)clearDiskCacheOnCompletion:(void(^)())completion{
    
    dispatch_async(self.ioQueue, ^{
        [_fileManager removeItemAtPath:self.diskCachePath error:nil];
        [_fileManager createDirectoryAtPath:self.diskCachePath
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:NULL];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

#pragma mark -  获取自己设定的Cache内容大小，非整个沙盒Cache文件夹大小

- (NSUInteger)getSize {
    __block NSUInteger size = 0;
    dispatch_sync(self.ioQueue, ^{
        NSDirectoryEnumerator *fileEnumerator = [_fileManager enumeratorAtPath:self.diskCachePath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    });
    return size;
}


#pragma mark -  清空整个Cache目录
/*
 *  清空整个Cache目录
 */
- (void)clearAllDiskCache {
    [self clearAllDiskCacheOnCompletion:nil];
}

- (void)clearAllDiskCacheOnCompletion:(void(^)())completion{
    
    dispatch_async(self.ioQueue, ^{
        NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        [self clearDiskCacheWithPath:cachePath];
        
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}




- (BOOL)clearDiskCacheWithPath:(NSString *)cachePath {
    
    NSArray * subPathArr = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    for (NSString * subPath in subPathArr) {
        
        NSError * error = nil ;
        NSString * path = [cachePath stringByAppendingPathComponent:subPath];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
        if (error) {
            return NO;
        }
    }
    return YES;
}


#pragma mark -  获取Cache文件夹全部内容大小

/*
 *  获取Cache文件夹全部内容大小，包括了SDWebImage的缓存
 */
- (NSString *)sizeOfALLDiskCache {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSUInteger totleSize = [self folderSizeAtPath:cachePath];
    
    NSString *sizeString = nil;
    
    if (totleSize > 1000 * 1000){
        sizeString = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        sizeString = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f];
        
    }else{
        sizeString = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    
    return sizeString;
}


/*
 *  获取指定目录中的所有文件内容大小
 */
- (NSUInteger)folderSizeAtPath:(NSString *)folderPath {
    
    __block NSUInteger folderSize = 0;
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0 ;
    
    dispatch_sync(self.ioQueue, ^{
        
        NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:folderPath];
        
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            folderSize += [attrs fileSize];
        }
    });
    return folderSize;
}


/////////
- (float)filePath {
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    return [self folderSizeAtPath:cachPath];
}


/*
 *  获取指定文件的大小
 */
- (float)fileSizeAtPath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}



// 没有用到
+ (NSString *)getCacheSizeWithFilePath:(NSString *)path{
    
    NSArray *subPathArr = [[NSFileManager defaultManager] subpathsAtPath:path];
    
    NSString *filePath  = nil;
    NSInteger totleSize = 0;
    
    for (NSString *subPath in subPathArr){
        
        filePath =[path stringByAppendingPathComponent:subPath];
        BOOL isDirectory = NO;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        if (!isExist || isDirectory || [filePath containsString:@".DS"]){
            // 过滤: 1. 文件夹不存在  2. 过滤文件夹  3. 隐藏文件
            continue;
        }
        
        NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        /**
         attributesOfItemAtPath: 文件夹路径
         该方法只能获取文件的属性, 无法获取文件夹属性, 所以也是需要遍历文件夹的每一个文件的原因
         */
        
        NSInteger size = [dict[@"NSFileSize"] integerValue];
        totleSize += size;
    }
    
    //8. 将文件夹大小转换为 M/KB/B
    NSString *totleStr = nil;
    
    if (totleSize > 1000 * 1000){
        totleStr = [NSString stringWithFormat:@"%.2fM",totleSize / 1000.00f /1000.00f];
        
    }else if (totleSize > 1000){
        totleStr = [NSString stringWithFormat:@"%.2fKB",totleSize / 1000.00f];
        
    }else{
        totleStr = [NSString stringWithFormat:@"%.2fB",totleSize / 1.00f];
    }
    
    return totleStr;
}



@end
