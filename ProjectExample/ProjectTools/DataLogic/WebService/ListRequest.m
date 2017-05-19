//
//  ListRequest.m
//  ProjectTools
//
//  Created by Vols on 2017/5/18.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "ListRequest.h"
#import "VHttpHelper.h"
#import "ReportModel.h"
#define kEncryptionUsername     @"mVhWiVtRsPtMoRrMwO"

@implementation ListRequest

//获取个股的研报信息
+ (void)getReports:(NSString *)key page:(NSUInteger)page success:(void (^)(NSArray *resultArray))success failue:(void (^)(NSString *errorMsg))failue {
    /*
    NSDictionary * parmas = @{@"action":@"search", @"itype":@"code",  @"key":key, @"page":@(page), @"username":kEncryptionUsername};
    
    [[VHttpHelper shared] post:parmas path:@"" success:^(id flag) {
        NSLog(@"个股研报 --> %@", (NSDictionary *)flag);
        
        NSString * status = ((NSDictionary*)flag)[@"status"];
        if ([status integerValue] == 0) {
            NSMutableArray * resultArray = [[NSMutableArray alloc] init];
            
            NSArray * analystArray =(NSArray *)((NSDictionary *)flag[@"data"][@"list"]);
            for (NSDictionary *parmasDict in analystArray) {
                ReportModel *model = [[ReportModel alloc]initWithDictionary:parmasDict];
                [resultArray addObject:model];
            }
            if (success) {
                success(resultArray);
            }
        }
        else {
            if (failue) {
                failue(((NSDictionary *)flag[@"data"])[@"errorMsg"]);
            }
        }
        
    } failue:^(NSError *error) {
        
    }];
     */
}


@end
