//
//  VLaunchAdPage.h
//  AdPage
//
//  Created by Vols on 2017/1/20.
//  Copyright © 2017年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

#define keyWindow  [UIApplication sharedApplication].keyWindow

typedef NS_ENUM(NSUInteger, LaunchAnimationType) {
    LaunchAnimationTypeNone,
    LaunchAnimationTypeFadeZoomOut,
    LaunchAnimationTypeFadeZoomIn,
};

typedef NS_ENUM(NSUInteger, VLaunchCacheType) {
    VLaunchCacheTypeNone,
    VLaunchCacheTypeDisk,
};

typedef void (^LaunchNoParmaBlock)();

@interface VLaunchAdPage : UIImageView

@property (nonatomic, assign) VLaunchCacheType      cacheType;
@property (nonatomic ,assign) LaunchAnimationType   popAnimationType;

@property (nonatomic, copy  ) LaunchNoParmaBlock    clickHandler;
@property (nonatomic, copy  ) LaunchNoParmaBlock    dismissHandler;

@property (nonatomic ,assign) BOOL hideSkip;    // 是否隐藏跳过按钮

/*
 *  本地图片
 */
+ (instancetype)launchPageWithImage:(UIImage *)adImage;
+ (instancetype)launchPageWithImage:(UIImage *)adImage duration:(NSInteger)duration;


/*
 *  网络图片
 */
+ (instancetype)launchPageWithImageURL:(NSString *)imageURL;
+ (instancetype)launchPageWithImageURL:(NSString *)imageURL duration:(NSInteger)duration;


/*
 *  自定义参数（可修改在内部实现先请求图片URL，在根据URL下载图片，加载图片）
 */
+ (instancetype)launchAdPage;



/*
 *  添加启动图 Parms：动画类型 及 点击回调
 */
- (void)showInWindowWithAnimationType:(LaunchAnimationType)animationType clickHandler:(LaunchNoParmaBlock)clickHandler;
- (void)showInView:(UIView *)superView animationType:(LaunchAnimationType)animationType clickHandler:(LaunchNoParmaBlock)clickHandler;



- (void)dismissAnimation;


@end
