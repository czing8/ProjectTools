//
//  AlipayManager.h
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PayResultBlock)(NSDictionary *resultDic);

@interface AlipayManager : NSObject

/**
 *  支付方法.传入商品信息可直跳转支付宝进行支付
 *
 *  @param productName    商品名称
 *  @param productDescription 商品描述
 *  @param amount 商品价格
 *  @param tradeNo 订单ID
 *  @param callback 支付结果回调
 */
+ (void)payForProductName:(NSString *)productName productDescription :(NSString *)productDescription
                  amount :(float)amount
                 tradeNo :(NSString *)tradeNo callback :(PayResultBlock)callback NS_DEPRECATED_IOS(2_0, 2_0, "等待填写支付宝商家信息，方法暂不可用");
@end
