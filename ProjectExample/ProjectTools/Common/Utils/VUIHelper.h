//
//  VUIHelper.h
//  ProjectTools
//
//  Created by Vols on 2016/11/30.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VUIHelper : NSObject

#pragma mark - ImageView
+ (UIImageView *)imageViewWithImage:(NSString *)imageString;

#pragma mark - Button

+ (UIButton *)buttonWithTitle:(NSString *)title
                     fontSize:(CGFloat)size
                       target:(id)target
                       action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title
                     fontSize:(CGFloat)size
              backgroundColor:(UIColor *)backgroundColor
                    textColor:(UIColor *)textColor
                       target:(id)target
                       action:(SEL)action;


#pragma mark - Label

+ (UILabel *)labelWithText:(NSString*)text fontSize:(CGFloat)size;
+ (UILabel *)labelWithText:(NSString*)text fontSize:(CGFloat)size textAlignment:(NSTextAlignment)textAlignment;
+ (UILabel *)labelWithBackgroundColor:(UIColor *)backgroundColor
                            textColor:(UIColor *)textColor
                        textAlignment:(NSTextAlignment)textAlignment
                                 text:(NSString*)text
                             fontSize:(CGFloat)size;

#pragma mark - TextField

+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder;
+ (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder fontSize:(CGFloat)size;


@end
