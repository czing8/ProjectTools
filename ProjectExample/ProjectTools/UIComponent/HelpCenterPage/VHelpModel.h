//
//  VHelpModel.h
//  ProjectTools
//
//  Created by Vols on 2016/2/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VHelpModel : NSObject

@property (nonatomic, strong) NSString  * answerString;
@property (nonatomic, strong) NSString  * questionString;

@property (nonatomic, assign, getter = isOpened) BOOL opened;

@end
