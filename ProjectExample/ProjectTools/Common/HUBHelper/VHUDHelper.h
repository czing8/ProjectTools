//
//  VHUDHelper.h
//  HUDHelper
//
//  Created by Vols on 2015/11/28.
//  Copyright © 2015年 vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface VHUDHelper : NSObject

+ (VHUDHelper *)shared;

/*
 *  提示框，加载
 */
- (void)loading;
- (void)loading:(NSString *)msg;
- (void)loading:(NSString *)msg inView:(UIView *)view;

- (void)stopLoading;
- (void)stopLoading:(NSString *)msg;
- (void)stopLoading:(NSString *)msg completion:(void (^)())completion;
- (void)stopLoading:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;



/*
 *  提示框，自动消失
 */
- (void)tipMessage:(NSString *)msg;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;

- (void)tipMessage:(NSString *)msg inView:(UIView *)view;

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds inView:(UIView *)view completion:(void (^)())completion;

/*
+ (VHUDHelper *)shared;

- (void)show;
- (void)show:(NSString *)msg;
- (void)show:(NSString *)msg inView:(UIView *)view;

- (void)hideHUD;
- (void)hideHUDMessage:(NSString *)msg;
- (void)hideHUDMessage:(NSString *)msg completion:(void (^)())completion;
- (void)hideHUDMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;


- (void)tipMessage:(NSString *)msg;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds;
- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;


- (MBProgressHUD *)loading;
- (MBProgressHUD *)loading:(NSString *)msg;
- (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view;

- (void)stopLoading:(MBProgressHUD *)hud;
- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg;
- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion;


- (void)loading:(NSString *)msg delay:(CGFloat)seconds execute:(void (^)())exec completion:(void (^)())completion;
*/


@end
