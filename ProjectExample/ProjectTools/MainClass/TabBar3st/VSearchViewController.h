//
//  VSearchViewController.h
//  ProjectTools
//
//  Created by Vols on 2016/2/13.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VBase1ViewController.h"
typedef void (^RefreshStockBlock)();

@interface VSearchViewController : VBase1ViewController

@property (nonatomic, copy) RefreshStockBlock refreshStockListHandler;

@end
