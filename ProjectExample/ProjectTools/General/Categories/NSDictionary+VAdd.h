//
//  NSDictionary+Extension.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (VAdd)

- (NSString *)urlEncodedKeyValueString;

- (NSString *)jsonEncodedKeyValueString;

- (NSString *)plistEncodedKeyValueString;

@end
