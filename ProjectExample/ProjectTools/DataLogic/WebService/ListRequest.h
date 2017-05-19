//
//  ListRequest.h
//  ProjectTools
//
//  Created by Vols on 2017/5/18.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListRequest : NSObject

+ (void)getReports:(NSString *)key page:(NSUInteger)page success:(void (^)(NSArray *resultArray))success failue:(void (^)(NSString *errorMsg))failue;

@end
