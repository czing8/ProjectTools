//
//  HSNetwork.m
//  HaierSmart
//
//  Created by Vols on 16/3/3.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "HSHttpRequest.h"
#import <AFNetworking.h>

@implementation HSHttpRequest

+ (id)shared {
    
    static HSHttpRequest *_sharedClient = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedClient = [[self alloc] init];
    });
    
    return _sharedClient;
}


#pragma 监测网络的可链接性
- (BOOL) netWorkReachabilityWithURLString:(NSString *) strUrl
{
    __block BOOL netState = NO;
    
    NSURL *baseURL = [NSURL URLWithString:strUrl];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    NSOperationQueue *operationQueue = manager.operationQueue;
    
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    
    return netState;
}

- (void)post:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure
{
    NSString * hostURL = kBaseURL;
    NSURL * baseURL = [NSURL URLWithString:hostURL];

    NSMutableDictionary * dict = [self handlerWithParamsDic:data];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    [manager.securityPolicy setAllowInvalidCertificates:YES];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSLog(@"request path: %@, parameters --> %@", path, dict);

    [manager POST:path parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        
        if (responseObject == nil) {
            HSError * hsError = [HSError errorWithCode:-100];
            failure(hsError);

//            success(@{@"code":@"-100",@"message":@"没有返回数据，可能服务器错误"});
        }
        else{
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error --> %@", error);

        HSError * hsError = [HSError errorWithCode:error.code];
        failure(hsError);
    }];
}


- (void)get:(NSDictionary *)data path:(NSString *)path success:(SuccessBlock)success failue:(FailureBlock)failure
{
    NSString * hostURL = kBaseURL;
    NSURL * baseURL = [NSURL URLWithString:hostURL];
    
    NSMutableDictionary * dict = [self handlerWithParamsDic:data];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    [manager.securityPolicy setAllowInvalidCertificates:YES];

//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"request path: %@, parameters --> %@", path, dict);

    [manager GET:path parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@", responseObject);
        
        if (responseObject == nil) {
//            success(@{@"code":@"-100",@"message":@"没有返回数据，可能服务器错误"});
            HSError * hsError = [HSError errorWithCode:-100];
            failure(hsError);
        }
        else{
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HSError * hsError = [HSError errorWithCode:error.code];
        failure(hsError);
    }];
}









// 对参数进行处理（增加公共参数）
- (NSMutableDictionary *)handlerWithParamsDic:(NSDictionary *)dic{
    
    if (dic == nil) {
        return nil;
    }
    
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    //    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    [params setObject: [infoDictionary objectForKey:@"CFBundleVersion"] forKey:@"v"];
    
    return params;
}


@end
