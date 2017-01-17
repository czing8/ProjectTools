//
//  VLocationManager.h
//  VLocationDemo
//
//  Created by Vols on 15/3/17.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationSuccessBlock)(NSString *lat,NSString *lng);  //（先纬度，后经度）
typedef void(^LocationFailBlock)(NSString *errorString, NSUInteger Code);

@interface VLocationHelper : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

+ (id)sharedInstance;

- (void)startUpdatingLocation:(LocationSuccessBlock)completion failure:(LocationFailBlock)failure;

- (void)stop;

@end
