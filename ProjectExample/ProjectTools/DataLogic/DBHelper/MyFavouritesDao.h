//
//  MyFavouritesDao.h
//  HaierSmart
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

/**
 *  收藏夹本地的数据库增删改查操作
 */
#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "StockModel.h"

typedef void (^Completion)(BOOL success);

@interface MyFavouritesDao : NSObject

+ (void)insertFavourite:(StockModel *)goods completion:(Completion)completion;

+ (void)deleteFavouriteBy:(NSString *)ID completion:(Completion)completion;

+ (void)queryFavouriteData:(void(^)(NSArray *favourite))completion;

@end
