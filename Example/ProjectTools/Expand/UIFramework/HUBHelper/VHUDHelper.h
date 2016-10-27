//
//  VHUDHelper.h
//  ProjectTools
//
//  Created by Vols on 2016/10/26.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

#define kRequestTimeOutTime 30


@interface VHUDHelper : NSObject{
@private
    MBProgressHUD *_theHUD;
}


+ (VHUDHelper *)shared;

// 网络请求
- (MBProgressHUD *)loading;
- (MBProgressHUD *)loading:(NSString *)msg;
- (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view;


- (void)loading:(NSString *)msg delay:(CGFloat)seconds execute:(void (^)())exec completion:(void (^)())completion;

- (void)stopLoading:(MBProgressHUD *)hud;
- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg;
- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

- (void)tipMessage:(NSString *)msg;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

// 网络请求
- (void)show;
- (void)show:(NSString *)msg;
- (void)show:(NSString *)msg inView:(UIView *)view;

- (void)hideHUD;
- (void)hideHUDMessage:(NSString *)msg;
- (void)hideHUDMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;


@end
