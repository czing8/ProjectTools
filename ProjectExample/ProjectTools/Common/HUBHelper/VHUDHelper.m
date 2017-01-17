//
//  VHUDHelper.m
//  HUDHelper
//
//  Created by Vols on 2015/11/28.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VHUDHelper.h"

#define kHUDBaseTag         100000
#define kRequestTimeOutTime 30

@interface VHUDHelper ()

@end

@implementation VHUDHelper {
    MBProgressHUD *_theHUD;
}

+ (id)shared {
    static VHUDHelper *_sharedClient = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        _sharedClient = [[self alloc] init];
    });
    return _sharedClient;
}

- (void)tipMessage:(NSString *)msg {
    [self tipMessage:msg delay:2 completion:nil];
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds {
    [self tipMessage:msg delay:seconds completion:nil];
}

- (void)tipMessage:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion
{
    if ([self isEmpty:msg]) return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = msg;
        hud.label.textColor = [UIColor whiteColor];
        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.userInteractionEnabled = NO;
        
        [hud hideAnimated:YES afterDelay:seconds];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    });
}



- (void)loading {
    [self loading:nil];
}

- (void)loading:(NSString *)msg {
    [self loading:msg inView:nil];
    
}

- (void)loading:(NSString *)msg inView:(UIView *)view {
    if (_theHUD)  {
        _theHUD.tag++;
        
        if (![self isEmpty:msg]) {
            _theHUD.label.text = msg;
            _theHUD.mode = MBProgressHUDModeText;
        }
        else {
            _theHUD.label.text = nil;
            _theHUD.mode = MBProgressHUDModeIndeterminate;
        }
        
        return;
    }
    _theHUD = [self hudWithMsg:msg inView:view];
    _theHUD.tag = kHUDBaseTag;
}




- (void)stopLoading {
    [self stopLoading:nil delay:1 completion:nil];
}

- (void)stopLoading:(NSString *)msg {
    [self stopLoading:msg delay:1 completion:nil];
}

- (void)stopLoading:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion{
    _theHUD.tag--;
    
    if (_theHUD.tag > kHUDBaseTag) {
        if (![self isEmpty:msg]) {
            _theHUD.label.text = msg;
            _theHUD.mode = MBProgressHUDModeText;
        }
        else  {
            _theHUD.label.text = nil;
            _theHUD.mode = MBProgressHUDModeIndeterminate;
        }
    }
    else  {
        [self hide:_theHUD message:msg delay:seconds completion:completion];
    }
}


#pragma mark - Private Methods

- (MBProgressHUD *)hudWithMsg:(NSString *)msg inView:(UIView *)view {
    UIView *inView = view ? view : [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:inView];
    hud.contentColor =  [UIColor whiteColor];
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.userInteractionEnabled = NO;
    if (![self isEmpty:msg]) {
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = msg;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [inView addSubview:hud];
        [hud showAnimated:YES];
        // 超时自动消失
        [hud hideAnimated:YES afterDelay:kRequestTimeOutTime];
    });
    return hud;
}


- (void)hide:(MBProgressHUD *)hud message:(NSString *)msg delay:(CGFloat)seconds completion:(void (^)())completion {
    
    if (hud && hud.superview) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![self isEmpty:msg]) {
                hud.label.text = msg;
                hud.mode = MBProgressHUDModeText;
            }
            
            [hud hideAnimated:YES afterDelay:seconds];
            _theHUD = nil;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (completion) {
                    completion();
                }
            });
        });
    }
    else {
        if (completion) {
            completion();
        }
    }
}


- (BOOL)isEmpty:(NSString *)string {
    return string == nil || string.length == 0;
}

@end
