//
//  VHttpHelper.h
//  ProjectTools
//
//  Created by Vols on 15/10/28.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id flag);
typedef void (^FailureBlock)(NSError *error);

typedef void (^PercentBlock)(float percent);

@interface VHttpHelper : NSObject


+ (id)shared;

#pragma
- (void)post:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure;
- (void)get:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure;

- (NSURLSessionDownloadTask *)down:(NSString *)URL percent:(PercentBlock)percent success:(void(^)(id flag, id filePath))success failue:(FailureBlock)failure;

- (void)cancel;


@end
