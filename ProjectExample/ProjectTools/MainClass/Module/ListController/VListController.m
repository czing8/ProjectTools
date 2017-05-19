//
//  VListController.m
//  ProjectTools
//
//  Created by Vols on 2017/5/18.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "VListController.h"
#import <MJRefresh.h>
#import "ReportTableCell.h"
#import "Masonry.h"
#import "ListRequest.h"
#define kRefreshInterval    20

@interface VListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   * tableView;
@property (nonatomic, strong) NSMutableArray* dataSource;

@end

@implementation VListController{
    NSDate *    _lastRefreshTime;   // 最后一次成功获取时间
    NSInteger   _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGB(230, 230, 230);
    
    _lastRefreshTime = [NSDate dateWithTimeIntervalSince1970:0];
    _page = 1;
    
    [self configureViews];
}

- (void)configureViews {
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor purpleColor];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // MJRefresh 刷新设置
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_header endRefreshing];
    }];
    mjHeader.automaticallyChangeAlpha = YES;
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    mjHeader.stateLabel.hidden = YES;
    
    MJRefreshBackNormalFooter *mjFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self.tableView.mj_footer endRefreshing];
    }];
    mjFooter.stateLabel.hidden = YES;
    
    self.tableView.mj_header = mjHeader;
    self.tableView.mj_footer = mjFooter;
    
}

#pragma mark - public








#pragma mark - Refresh Functions

- (void)loadData {
    NSDate *curTime = [NSDate date];
    NSTimeInterval interval = [curTime timeIntervalSinceDate:_lastRefreshTime];
    
    if (interval < kRefreshInterval) {
        
        [self.tableView.mj_header endRefreshing];
        return;
    }
    [self.dataSource removeAllObjects]; //清空数据
    [self loadDataWithPage:1];
}


- (void)loadNextPageData {
    _page ++;
    [self loadDataWithPage:_page];
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReportTableCell * cell = [tableView dequeueReusableCellWithIdentifier:kReportTableCellIdentifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.reportCellType = kReportCellTypeList;
    cell.model =  ((ReportModel *)self.dataSource[indexPath.row]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (void)loadDataWithPage:(NSInteger)page {
    [ListRequest getReports:_reportModel.stockCode page:page success:^(NSArray *resultArray) {
        [self.dataSource addObjectsFromArray:resultArray];
    } failue:^(NSString *errorMsg) {
        
    }];
}

#pragma mark - getters

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[ReportTableCell class] forCellReuseIdentifier:kReportTableCellIdentifier];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 80;
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
