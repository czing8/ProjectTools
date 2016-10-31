//
//  VHardwareInfo.h
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VHardwareInfo : NSObject

+ (NSInteger)numberProcessors;
+ (NSInteger)numberActiveProcessors;
+ (NSInteger)processorSpeed;
+ (NSInteger)processorBusSpeed;



+ (double)totalMemory;
+ (double)freeMemory:(BOOL)inPercent;
+ (double)usedMemory:(BOOL)inPercent;
+ (double)activeMemory:(BOOL)inPercent;
+ (double)inactiveMemory:(BOOL)inPercent;
+ (double)wiredMemory:(BOOL)inPercent;
+ (double)purgableMemory:(BOOL)inPercent;




@end
