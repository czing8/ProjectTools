//
//  HSError.h
//  HaierSmart
//
//  Created by Vols on 16/3/9.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HSErrorType) {
    HSErrorTypeNotReachable,
    HSErrorTypeServiceError,
    HSErrorTypeResultNull
};


@interface HSError : NSObject

@property (nonatomic, assign) HSErrorType errorType;

+ (HSError *) errorWithCode:(NSInteger)code;

@end
