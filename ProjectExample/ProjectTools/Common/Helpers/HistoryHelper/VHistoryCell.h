//
//  HistoryCell.h
//  ProjectTools
//
//  Created by Vols on 2016/2/13.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockModel.h"
#import "Masonry.h"

#define kStockHistoryCellIdentifier     @"kStockHistoryCellIdentifier"

typedef void(^ClickHandler)();

@interface VHistoryCell : UITableViewCell

@property (nonatomic, strong) StockModel        * model;
@property (nonatomic, strong) UIButton          * handleBtn;
@property (nonatomic, copy  ) ClickHandler      clickHandler;

@property (nonatomic, assign) BOOL isStockSelected;

@end
