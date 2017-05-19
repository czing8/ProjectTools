//
//  VTextSwitch.h
//  VariousButtons
//
//  Created by Vols on 2015/11/21.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VTextSwitch : UIControl

@property (nonatomic, assign, getter = isOn) BOOL on;

@property (nonatomic, strong) UIColor   * onTintColor;
@property (nonatomic, strong) UIColor   * tintColor;
@property (nonatomic, strong) UIColor   * thumbTintColor;
@property (nonatomic, assign) NSInteger switchKnobSize;
@property (nonatomic, strong) UIColor   * textColor;
@property (nonatomic, strong) UIFont    * textFont;

@property (nonatomic, strong) NSString  * onText;
@property (nonatomic, strong) NSString  * offText;


+ (instancetype)switchWithFrame:(CGRect)frame onColor:(UIColor *)onColor offColor:(UIColor *)offColor font:(float)font ballSize:(NSInteger )ballSize;

- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
