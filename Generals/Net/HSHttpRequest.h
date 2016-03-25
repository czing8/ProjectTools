//
//  HSNetwork.h
//  HaierSmart
//
//  Created by Vols on 16/3/3.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSError.h"

typedef void (^SuccessBlock)(id flag);
typedef void (^FailureBlock)(HSError *error);


typedef void (^ResultBlock)(id flag);


@interface HSHttpRequest : NSObject

+ (id)shared;

#pragma 监测网络的可链接性
- (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl;

#pragma
- (void)post:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure;
- (void)get:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure;


@end
