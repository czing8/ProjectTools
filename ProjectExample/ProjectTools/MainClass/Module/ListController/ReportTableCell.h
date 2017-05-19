//
//  ConsultingCell.h
//  HBDemo
//
//  Created by Vols on 2016/10/21.
//  Copyright © 2016年 Vols. All rights reserved.
//  研报列表页 的cell

#import <UIKit/UIKit.h>
#import "ReportTableCell.h"
#import "ReportModel.h"

typedef NS_ENUM(NSInteger, kReportCellType) {
    kReportCellTypeList,            //列表页
    kReportCellTypeSearch           //搜索确认页
};

#define kReportTableCellIdentifier @"kReportTableCellIdentifier"
@interface ReportTableCell : UITableViewCell

@property (nonatomic, strong) ReportModel * model;
@property (nonatomic, assign) kReportCellType reportCellType;

@end
