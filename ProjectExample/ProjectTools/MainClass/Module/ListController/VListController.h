//
//  VListController.h
//  ProjectTools
//
//  Created by Vols on 2017/5/18.
//  Copyright © 2017年 Vols. All rights reserved.
//  列表模板，上拉刷新，下拉加载

#import "VBase1ViewController.h"
#import "ReportModel.h"

@interface VListController : VBase1ViewController

@property (nonatomic, strong) ReportModel * reportModel;


- (void)reloadData;


@end
