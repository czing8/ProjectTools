//
//  NSString+VAdd.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VAdd)

+ (BOOL)isEmpty:(NSString *)string;

// 将str加密成本地保存的文件名
+ (NSString *)md5String:(NSString *)str;
- (NSString *)md5;


//是否包含给定的字符串, 忽略大小写
- (BOOL)isContainsString:(NSString *)str;
//以指定条件判断是否包含给定的字符串
- (BOOL)isContainsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

//是否有中文
- (BOOL)isContainsChinese;

//是否有纯数字
- (BOOL)isPureNum;

//去掉空格
- (NSString *)stringByTrim;

//是否手机号
- (BOOL)isMobileNumber;

//将字符串以URL格式编码
- (NSString*)urlEncodedString;
- (NSString*)urlDecodedString;


@end










