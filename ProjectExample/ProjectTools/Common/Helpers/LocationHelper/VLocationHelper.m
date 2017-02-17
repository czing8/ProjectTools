//
//  VLocationManager.m
//  VLocationDemo
//
//  Created by Vols on 15/3/17.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VLocationHelper.h"

@interface VLocationHelper ()

@property (nonatomic, copy) LocationSuccessBlock completionBlock;
@property (nonatomic, copy) LocationFailBlock failBlock;

@end

@implementation VLocationHelper

+(id)sharedInstance{
    static VLocationHelper *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


- (void)stop{
    [_locationManager stopUpdatingLocation];
}

-(void)startUpdatingLocation:(LocationSuccessBlock)completion failure:(LocationFailBlock)failure{
    
    _completionBlock = completion;
    _failBlock = failure;
    
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
        
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0) {
            [_locationManager requestAlwaysAuthorization]; //使用程序其间允许访问位置数据（iOS8定位需要）
        }
    }
    
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
}

//- (void)getUserPosWithFailure:(FailBlock)failure{
//    _failBlock = [failure copy];
//}


#pragma mark - CLLocation Delegate Methods


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSString *errorString = nil;
    NSUInteger code = 404;
    
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            // 什么都不做，不能进行定位（这种情况常见于第一次安装应用打开后用户还未决定如何选择定位方式）
            
            errorString = @"定位授权状态：———— 用户还未决定授权状态！";
            
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [_locationManager requestWhenInUseAuthorization]; //用这个方法，plist里要加字段NSLocationWhenInUseUsageDescription
            }
        }
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways: {
            errorString = @"定位授权状态：———— 已授权一直定位！";
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
                [_locationManager requestAlwaysAuthorization];
                [_locationManager startUpdatingLocation];
            }
            
            _failBlock(errorString, code);
        }

        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            errorString = @"定位授权状态：———— 已授权使用期间定位！";
            if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
                [_locationManager requestWhenInUseAuthorization];   //plist里要加字段NSLocationWhenInUseUsageDescription
                [_locationManager startUpdatingLocation];
            }
        }
            break;
        case kCLAuthorizationStatusDenied: {
            errorString = @"定位授权状态：———— 已拒绝定位！";
            [_locationManager stopUpdatingLocation];    // 停止刷新定位
        }
            break;
            
        default:{
            
        }
            break;
    }
}
#endif


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *theLocation = [locations lastObject];
    NSString *latitude = [NSString stringWithFormat:@"%g\u00B0",theLocation.coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%g\u00B0",theLocation.coordinate.longitude];
    
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    
    if(_completionBlock){
        _completionBlock(latitude, longitude);
    }
}


/**
 *定位失败，回调此方法
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    BOOL shouldQuit;
    NSMutableString *errorString = [[NSMutableString alloc] init];
    NSUInteger code = 404;
    
    if ([error domain] == kCLErrorDomain) {
        
        switch ([error code]) {
                
            case kCLErrorDenied:{
                [errorString appendFormat:@"定位服务已经关闭"];
                [errorString appendFormat:@"\n请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许本应用使用定位服务"];
                shouldQuit = YES;
                code = 400;
                break;
            }
                
            case kCLErrorLocationUnknown:{
                [errorString appendFormat:@"无法获取位置信息\n"];
                shouldQuit = YES;

                break;
            }
            default:
                [errorString appendFormat:@"%@ %ld\n", @"GenericLocationError", (long)[error code]];
                shouldQuit = NO;
                break;
        }
        
    }else {
        
        [errorString appendFormat:@"Error domain: \"%@\"  Error code: %ld\n", [error domain], (long)[error code]];
        [errorString appendFormat:@"Description: \"%@\"\n", [error localizedDescription]];
        shouldQuit = NO;
    }
    
    // TODO: Send the delegate the alert?
    if (shouldQuit) {
        // do nothing
    }
    
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    
    _failBlock(errorString, code);
}

@end
