//
//  DBHelper.h
//  HaierSmart
//
//  Created by Vols on 16/3/9.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"

@interface DBHelper : NSObject

@property (nonatomic, strong) FMDatabaseQueue * dbQueue;
@property (nonatomic, strong) NSString * dbPath;

+ (DBHelper *)sharedDB;

@end
