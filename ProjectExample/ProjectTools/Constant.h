//
//  Constant.h
//  PrejectTools
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define WS(weakSelf)    __weak __typeof(&*self)weakSelf = self;

#define kRGB(r, g, b)       [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define kRGBA(r, g, b, a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kRGBHex(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kShareAppDelegate   ((AppDelegate*)[UIApplication sharedApplication].delegate)

#define kKeyWindow          [UIApplication sharedApplication].keyWindow

#define kSCREEN_SIZE        [UIScreen mainScreen].bounds.size


#define kCommonMidTextFont  [UIFont systemFontOfSize:14]

#define kLoginStatus        @"loginStatus"
#define kNewUserGuide       @"newuserguide"    //是否新手引导页


#ifdef DEBUG
//#define VLog(...) NSLog(__VA_ARGS__)
#define VLog(format, ...) NSLog((@"%@ " format), [[NSString stringWithUTF8String:__FILE__] lastPathComponent], ##__VA_ARGS__);
#else
#define VLog(...)
#endif

#endif /* Constant_h */
