//
//  UIColor+Project.m
//  
//
//  Created by Vols on 2015/11/30.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "UIColor+Project.h"

#define kRGB(r, g, b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kRGBHex(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation UIColor (Project)

+ (UIColor *)redButtonColor {
    return kRGB(237, 80, 82);
}

+ (UIColor *)navThemeColor {
    return kRGBHex(0xDC4B53);
}

+ (UIColor *)flatDarkRedColor {
    return kRGBHex(0xC0392B);
}

@end
