//
//  VHUBHelper.m
//  ProjectTools
//
//  Created by Vols on 2016/10/26.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VHUDHelper.h"
#import "NSString+VAdd.h"


@implementation VHUDHelper

+ (id)shared {
    static VHUDHelper *_sharedClient = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}



- (MBProgressHUD *)loading {
    return [self loading:nil];
}

- (MBProgressHUD *)loading:(NSString *)msg {
    return [self loading:msg inView:nil];
}

- (MBProgressHUD *)loading:(NSString *)msg inView:(UIView *)view {
    UIView *inView = view ? view : [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![NSString isEmpty:msg])
        {
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = msg;
        }
        [inView addSubview:hud];
        [hud show:YES];
        // 超时自动消失
         [hud hide:YES afterDelay:kRequestTimeOutTime];
    });
    return hud;
}

- (void)loading:(NSString *)msg delay:(CGFloat)seconds execute:(void (^)())exec completion:(void (^)())completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *inView = [UIApplication sharedApplication].keyWindow;
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
        if (![NSString isEmpty:msg]) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = msg;
        }
        
        [inView addSubview:hud];
        [hud show:YES];
        if (exec) {
            exec();
        }
        
        [hud hide:YES afterDelay:seconds];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}


- (void)stopLoading:(MBProgressHUD *)hud
{
    [self stopLoading:hud message:nil];
}

- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg
{
    [self stopLoading:hud message:msg delay:0 completion:nil];
}
- (void)stopLoading:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion
{
    if (hud && hud.superview) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![NSString isEmpty:msg])
            {
                hud.labelText = msg;
                hud.mode = MBProgressHUDModeText;
            }
            
            [hud hide:YES afterDelay:seconds];
            _theHUD = nil;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    }
    else {
        if (completion)   {
            completion();
        }
    }
    
}


- (void)tipMessage:(NSString *)msg {
    [self tipMessage:msg delay:2];
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds {
    [self tipMessage:msg delay:seconds completion:nil];
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion {
    if ([NSString isEmpty:msg]) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
        [[UIApplication sharedApplication].keyWindow addSubview:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = msg;
        [hud show:YES];
        [hud hide:YES afterDelay:seconds];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}


#define kSyncHUDStartTag  100000

// 网络请求
- (void)show {
    [self show:nil];
}

- (void)show:(NSString *)msg {
    [self show:msg inView:nil];
}

- (void)show:(NSString *)msg inView:(UIView *)view {
    if (_theHUD) {
        _theHUD.tag++;
        
        if (![NSString isEmpty:msg]) {
            _theHUD.labelText = msg;
            _theHUD.mode = MBProgressHUDModeText;
        }
        else {
            _theHUD.labelText = nil;
            _theHUD.mode = MBProgressHUDModeIndeterminate;
        }
        
        return;
    }
    _theHUD = [self loading:msg inView:view];
    _theHUD.tag = kSyncHUDStartTag;
}

- (void)hideHUD {
    [self hideHUDMessage:nil delay:0.1 completion:nil];
}

- (void)hideHUDMessage:(NSString *)msg {
    [self hideHUDMessage:msg delay:1 completion:nil];
}

- (void)hideHUDMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion {
    _theHUD.tag--;
    if (_theHUD.tag > kSyncHUDStartTag) {
        if (![NSString isEmpty:msg]) {
            _theHUD.labelText = msg;
            _theHUD.mode = MBProgressHUDModeText;
        }
        else {
            _theHUD.labelText = nil;
            _theHUD.mode = MBProgressHUDModeIndeterminate;
        }
    }
    else {
        [self stopLoading:_theHUD message:msg delay:seconds completion:completion];
    }
}


@end
