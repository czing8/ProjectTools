//
//  VUIHelper.m
//  ProjectTools
//
//  Created by Vols on 2016/11/30.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VUIHelper.h"

#define kDefaultSize            14
#define kDefaultNumberOfLines   1

@implementation VUIHelper

#pragma mark - Label

+ (UILabel *)labelWithText:(NSString*)text fontSize:(CGFloat)size {
    return [VUIHelper labelWithBackgroundColor:nil textColor:nil textAlignment:NSTextAlignmentLeft text:text fontSize:size];
}

+ (UILabel *)labelWithText:(NSString*)text fontSize:(CGFloat)size textAlignment:(NSTextAlignment)textAlignment {
    return [VUIHelper labelWithBackgroundColor:nil textColor:nil textAlignment:textAlignment  text:text fontSize:size];
}


+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                                 text:(NSString*)text
                             fontSize:(CGFloat)size {
    UILabel * label = [[UILabel alloc] init];
    
    if (backgroundColor)    label.backgroundColor = backgroundColor;
    if (textColor)          label.textColor = textColor;
    if (text)               label.text = text;

    label.textAlignment = textAlignment;
    label.font = [UIFont systemFontOfSize:size];

    return label;
}


#pragma mark - Button

+ (UIButton *)buttonWithTitle:(NSString *)title
                     fontSize:(CGFloat)size
                       target:(id)target
                       action:(SEL)action {
    return [self buttonWithTitle:title fontSize:size backgroundColor:nil textColor:nil target:target action:action];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                     fontSize:(CGFloat)size
              backgroundColor:(UIColor *)backgroundColor
                    textColor:(UIColor *)textColor
                       target:(id)target
                       action:(SEL)action {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (backgroundColor)    btn.backgroundColor = backgroundColor;
    if (textColor)          [btn setTitleColor:textColor forState:UIControlStateNormal];
    if (title)              [btn setTitle:title forState:UIControlStateNormal];
    
    if (target && action)
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:size];
    
    return btn;
}


#pragma mark - ImageView

+ (UIImageView *)imageViewWithImage:(NSString *)imageString {
    UIImageView *iView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageString]];
    return iView;
}

#pragma mark - TextField

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder {
    UITextField * textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    return textField;
}


+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder fontSize:(CGFloat)size{
    UITextField * textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:size];
    return textField;
}


@end
