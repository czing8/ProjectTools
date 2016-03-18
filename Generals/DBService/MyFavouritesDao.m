//
//  MyFavouritesDao.m
//  HaierSmart
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "MyFavouritesDao.h"
#import "DBHelper.h"

#import "HSGoodsModel.h"

@implementation MyFavouritesDao

+ (void) insertFavourite:(HSGoodsModel *)goods completion:(Completion)completion{
    
//    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
//        if (![db tableExists:@"favourites_table"]) {
//            [db executeUpdate:@"create table favourites_table(  PRIMARY KEY, ,  ,  ,  )"];
//        }
//        BOOL success = [db executeUpdate:@"", , ];
//        completion(success);
//    }];
}


+ (void)deleteFavouriteByID:(NSString *)ID completion:(Completion)completion{

//    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
//        
//        BOOL success = [db executeUpdate:@"delete from favourites_table where  = ?",ID];
//        completion(success);
//    }];
}

+ (void)queryFavouriteByID:(NSString *)ID completion:(void(^)(HSGoodsModel *goods))completion{
//    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
//        if (![db tableExists:@"favourites_table"]) {
//            //            [db executeUpdate:@"create table users_list(user_id PRIMARY KEY, phone_num, nickname, birthday, flavor)"];
//            
//        }
//        
//        HSGoodsModel * goods = nil;
//        FMResultSet *rs = [db executeQuery:@"select * from favourites_table where id = ?", ID];
//        
//        if ([rs next]) {
//            goods = [MyFavouritesDao goodsForRS:rs];
//        }
//        [rs close];
//        
//        completion(goods);
//    }];
}



#pragma mark - helper
+ (HSGoodsModel *)goodsForRS: (FMResultSet*)rs{
    
    HSGoodsModel * goods  = [[HSGoodsModel alloc] init];
    
//    account.userID = [rs stringForColumn:@"user_id"];
//    account.phoneNum = [rs stringForColumn:@"phone_num"];
//    account.nickname = [rs stringForColumn:@"nickname"];
//    account.birthday = [rs stringForColumn:@"birthday"];
//    account.flavor = [rs stringForColumn:@"flavor"];
    
    return goods;
}


@end
