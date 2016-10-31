//
//  UIColor+Extends.m
//  
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "UIColor+Extends.h"

@implementation UIColor (Extends)


+ (UIColor *)randomColor {
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
