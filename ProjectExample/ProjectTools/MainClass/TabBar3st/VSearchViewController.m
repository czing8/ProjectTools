//
//  VSearchViewController.m
//  ProjectTools
//
//  Created by Vols on 2016/2/13.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VSearchViewController.h"

#import "VHistoryCell.h"
#import "VHistoryHelper.h"


@interface VSearchViewController () <UISearchBarDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView        * searchNavBar;
@property (nonatomic, strong) UIButton      * closeButton;
@property (nonatomic, strong) UISearchBar   * searchBar;

@property (nonatomic, strong) UITableView       * tableView;
@property (nonatomic, strong) NSMutableArray    * dataSource;

@end

@implementation VSearchViewController{
    VHistoryHelper * _stockHistoryHelper;
    
}

#pragma mark - View Lifecycle

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self configureViews];
    
    _stockHistoryHelper = [[VHistoryHelper alloc] initWithHistoryType:HistoryTypeStock100];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_searchBar becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
}


- (void)initData {
    [self testData];
}

- (void)testData {
    
    for (int i = 0; i < 5; i ++) {
        StockModel * model = [[StockModel alloc] init];
        model.stockName = @"乐凯新材";
        model.stockCode = @"300446";
        model.isSelect = i%2 ? YES : NO;
//        model.sid = @"222222";
        
        [self.dataSource addObject:model];
    }
}

- (void)configureViews {
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.searchNavBar];
    [self.view addSubview:self.tableView];
    [_searchNavBar addSubview:self.closeButton];
    [_searchNavBar addSubview:self.searchBar];
    
    [_searchNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.top.equalTo(_searchNavBar.superview);
        make.height.mas_equalTo(@(64));
    }];
    
    
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(@(0));
        make.bottom.mas_equalTo(@(0));
        make.size.mas_equalTo(CGSizeMake(64, 44));
    }];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(10));
        make.right.equalTo(_closeButton.mas_left);
        make.bottom.mas_equalTo(@(0));
        make.height.mas_equalTo(@(44));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_tableView.superview);
        make.top.equalTo(_searchNavBar.mas_bottom);
    }];
    
}

#pragma mark - actions
- (void)backAction:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Properties

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIButton *)closeButton{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _closeButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_closeButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIView *)searchNavBar {
    if (_searchNavBar == nil) {
        _searchNavBar = [UIView new];
        _searchNavBar.backgroundColor = [UIColor navThemeColor];
    }
    return _searchNavBar;
}

- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        [_searchBar setBackgroundImage:[[UIImage alloc] init]];
        _searchBar.placeholder = @"请输入股票代码、名称或拼音";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[VHistoryCell class] forCellReuseIdentifier:kStockHistoryCellIdentifier];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kStockHistoryCellIdentifier];
    
    cell.model = self.dataSource[indexPath.row];
    cell.clickHandler = ^(){
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //        AnalystModel * analystModel = ((AnalystModel *)self.dataSource[indexPath.row]);
    //
    //        ReportListController * reportListVC = [[ReportListController alloc] init];
    //        reportListVC.reportType = kReportTypeAnalyst;
    //        reportListVC.entityName = analystModel.author;
    //        reportListVC.isSelect   = analystModel.isSelect;
    //        reportListVC.dissmissCallBack = ^(){
    //            [self searchAnalyst:_searchBar.text];
    //        };
    //
    //        [self.navigationController pushViewController:reportListVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


#pragma mark - SearchBarDelegate Methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [_stockHistoryHelper bindHistoryListToView:self.searchNavBar clickHandler:^(StockModel *model) {
        
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length > 0) {
        [_stockHistoryHelper clearHistoryList];
    }
    else {
        [_stockHistoryHelper bindHistoryListToView:self.searchNavBar clickHandler:^(StockModel *model) {
            
        }];
    }
    
    //    if (_searchType == kSearchTypeAnalyst) {
    //        [self searchAnalyst:searchText];
    //    }else if (_searchType == kSearchTypeStock){
    //        [self searchStock:searchText];
    //    }
    [self.tableView reloadData];
}


#pragma mark - Helpers

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
