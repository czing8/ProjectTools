//
//  HSError.m
//  HaierSmart
//
//  Created by Vols on 16/3/9.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "HSError.h"

@implementation HSError

+ (HSError *)errorWithCode:(NSInteger)code
{
    return [[HSError alloc] initWithCode:code];
}

- (id) initWithCode:(NSInteger)code
{
    if (self = [super init]){
        [self doWithError:code];
    }
    return self;
}

- (void)doWithError:(NSInteger)code{
    
    if (code == -1009) {
        _errorType = HSErrorTypeNotReachable;
    }else if(code == -100){
        _errorType = HSErrorTypeResultNull;
    }else{
        _errorType = HSErrorTypeServiceError;
    }
}



@end
