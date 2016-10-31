//
//  AlipayManager.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "AlipayManager.h"

@implementation AlipayManager

#warning 待添加支付宝商户信息、设置服务器回调地址、设置URL Types

+ (void)payForProductName:(NSString *)productName productDescription:(NSString *)productDescription amount:(float)amount tradeNo :(NSString *)tradeNo callback :(PayResultBlock)callback
{
    //    // 1.商户申请时,会获取的内容
    //    NSString *partner = @"";
    //    NSString *seller = @"";
    //    NSString *privateKey = @"";
    //
    //    // 2.生成订单
    //    YMHAlipayOrder *order = [[YMHAlipayOrder alloc] init];
    //    order.partner = partner;
    //    order.seller = seller;
    //    order.tradeNO = tradeNo; // 订单ID
    //    order.productName = productName; //商品标题
    //    order.productDescription = productDescription; //商品描述
    //    order.amount = [NSString stringWithFormat:@"%.2f",amount]; //商品价格
    //
    //    // 设置服务器的回调地址
    //    order.notifyURL =  @""; //回调URL
    //    order.service = @"mobile.securitypay.pay";
    //    order.paymentType = @"1";
    //    order.inputCharset = @"utf-8";
    //    order.itBPay = @"30m"; // 超时时间(在这个时间如果用户没有支付,则该订单直接失效)
    //    order.showUrl = @"m.alipay.com";
    //
    //    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    //    NSString *appScheme = @"alipay";
    //
    //    //将商品信息拼接成字符串
    //    NSString *orderSpec = [order description];
    //
    //    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    //    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    //    NSString *signedString = [signer signString:orderSpec];
    //
    //    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    //    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
    //                             orderSpec, signedString, @"RSA"];
    //
    //    // 调用对应SDK,打开支付宝客户端,开始支付(如果用户手机安装客户端了,那么打开客户端进行支付.如果用户没有安装客户端,打开网页让用户支付,如果有支付结果,在这里回调)
    //    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
    //        callback(resultDic);
    //    }];
}


@end
