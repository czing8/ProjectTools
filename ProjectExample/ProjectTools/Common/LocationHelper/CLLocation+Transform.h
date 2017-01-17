//
//  CLLocation+Transform.h
//  ProjectTools
//
//  Created by Vols on 2016/11/4.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

// 分为 地球坐标，火星坐标（iOS mapView 高德 ， 国内google ,搜搜、阿里云 都是火星坐标），百度坐标(百度地图数据主要都是四维图新提供的)
//火星坐标: MKMapView
//地球坐标: CLLocationManager
//当用到CLLocationManager 得到的数据转化为火星坐标, MKMapView不用处理
//API                坐标系
//百度地图API         百度坐标
//腾讯搜搜地图API      火星坐标
//搜狐搜狗地图API      搜狗坐标
//阿里云地图API       火星坐标
//图吧MapBar地图API   图吧坐标
//高德MapABC地图API   火星坐标
//灵图51ditu地图API   火星坐标

@interface CLLocation (Transform)

//地图坐标 --> 火星坐标
- (CLLocation*)locationMarsFromEarth;

//火星坐标 --> 百度坐标
- (CLLocation*)locationBaiduFromMars;

//百度坐标 --> 火星坐标
- (CLLocation*)locationMarsFromBaidu;

@end
