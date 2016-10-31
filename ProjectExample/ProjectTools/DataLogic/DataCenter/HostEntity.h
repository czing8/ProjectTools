//
//  HostParam.h
//  HBDemo
//
//  Created by hibor on 16/10/28.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginEntity.h"
#import "UserInfoModel.h"

@interface HostEntity : NSObject

@property (nonatomic, strong) LoginEntity    *loginEntity;
@property (nonatomic, strong) UserInfoModel    *profile;

// 同步自己的个人资料
- (void)asyncProfile;

@end
