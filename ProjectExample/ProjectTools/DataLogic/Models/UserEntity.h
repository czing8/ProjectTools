//
//  UserEntity.h
//  ProjectTools
//
//  Created by Vols on 2016/11/5.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, UserGender) {
    GENDER_UNKNOWN      = 0,        //未知性别
    GENDER_MALE         = 1,        //男性
    GENDER_FEMALE       = 2,        //女性
};

typedef NS_ENUM(NSInteger, FriendAllowType) {
    FRIEND_ALLOW_ANY                    = 0,    // 同意任何用户加好友
    FRIEND_NEED_CONFIRM                 = 1,    // 需要验证
    FRIEND_DENY_ANY                     = 2,    //  拒绝任何人加好友
};


@interface UserEntity : NSObject

@property (nonatomic, strong) NSString      * identifier;

@property (nonatomic, strong) NSString      * moblie;
@property (nonatomic, strong) NSString      * faceURL;
@property (nonatomic, strong) NSString      * nickname;
@property (nonatomic, assign) UserGender    gender;
@property (nonatomic, assign) uint32_t      birthday;
@property (nonatomic, assign) uint32_t      language;           //语言
@property (nonatomic, strong) NSData        * selfSignature;    //用户签名
@property (nonatomic, strong) NSData        * location;         //好友区域
@property (nonatomic, strong) NSString      * remark;           //用户备注

@property (nonatomic, assign) FriendAllowType allowType;   //好友验证方式

@property (nonatomic, strong) NSArray   * friendGroups;    //好友分组名称 NSString* 列表

/**
 *  自定义字段集合,key是NSString*类型,value是NSData*类型
 *  (key值按照后台配置的字符串传入)
 */
@property (nonatomic, strong) NSDictionary  * customInfo;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
