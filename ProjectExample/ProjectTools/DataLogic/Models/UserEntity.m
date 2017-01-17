//
//  UserEntity.m
//  ProjectTools
//
//  Created by Vols on 2016/11/5.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "UserEntity.h"

#define kHandleParam(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;

@implementation UserEntity

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _identifier    = kHandleParam(@"identifier", @"");
        _moblie = kHandleParam(@"moblie", @"");
        
        //        if (dictionary[@"isSelect"] != nil && dictionary[@"isSelect"]!=[NSNull null]) {
        //            _isSelect = ([dictionary[@"isSelect"] isEqualToString:@"true"] ? YES: NO);
        //        }
    }
    return self;
}


@end
