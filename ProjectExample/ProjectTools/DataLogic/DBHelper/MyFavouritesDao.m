//
//  MyFavouritesDao.m
//  HaierSmart
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "MyFavouritesDao.h"


@implementation MyFavouritesDao

+ (void)insertFavourite:(StockModel *)goods completion:(Completion)completion {

//    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
//        if (![db tableExists:@"favourites_table"]) {
//            [db executeUpdate:@"create table favourites_table( PRIMARY KEY, ,  ,  ,  )"];
//        }
//        BOOL success = [db executeUpdate:@"", , ];
//        completion(success);
//    }];
}

+ (void)deleteFavouriteBy:(NSString *)ID completion:(Completion)completion{

//    [[DBHelper sharedDB].dbQueue inDatabase:^(FMDatabase *db) {
//        
//        BOOL success = [db executeUpdate:@"delete from favourites_table where  = ?",ID];
//        completion(success);
//    }];
}
//
+ (void)queryFavouriteData:(void(^)(NSArray *favourite))completion {

    
}




#pragma mark - helper
+ (StockModel *)stockForRS:(FMResultSet *)rs {
    
    StockModel * stock  = [[StockModel alloc] init];
    stock.stockCode = [rs stringForColumn:@"stock_code"];
    stock.stockName = [rs stringForColumn:@"stock_name"];
    stock.stockShortName = [rs stringForColumn:@"stock_shortName"];
    stock.stockType = [rs stringForColumn:@"stock_type"];
    stock.isSelect = [rs boolForColumn:@"isSelect"];
    
    return stock;
}


//+ (HSGoodsModel *)goodsForRS: (FMResultSet*)rs{
//
//    HSGoodsModel * goods  = [[HSGoodsModel alloc] init];
//
//    account.userID = [rs stringForColumn:@"user_id"];
//    account.phoneNum = [rs stringForColumn:@"phone_num"];
//    account.nickname = [rs stringForColumn:@"nickname"];
//    account.birthday = [rs stringForColumn:@"birthday"];
//    account.flavor = [rs stringForColumn:@"flavor"];
    
//    return goods;
//}


@end
