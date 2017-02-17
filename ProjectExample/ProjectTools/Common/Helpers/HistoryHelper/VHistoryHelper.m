//
//  VHistoryHelper.m
//  ProjectTools
//
//  Created by Vols on 2016/2/13.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VHistoryHelper.h"

@interface VHistoryHelper () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) HistoryType   historyType;

@property (nonatomic, weak  ) UIView        * attachView;
@property (nonatomic, strong) UITableView   * tableView;
@property (nonatomic, strong) NSMutableArray <StockModel*> * dataSource;

@property (nonatomic, copy) void(^clickHandler)(StockModel *);

@end

@implementation VHistoryHelper

- (instancetype)initWithHistoryType:(HistoryType)historyType {
    
    if (self = [super init]) {
        self.historyType = historyType;
        self.dataSource = [[NSMutableArray alloc] init];
    }
    
    return self;
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


#pragma mark - Pubilc

- (void)bindHistoryListToView:(UIView *)attachView clickHandler:(void (^)(StockModel *))clickHandler {
    
    // 如果存在tableView跳出
    if ([self isHistoryListExits])  return;
    
    self.attachView = attachView;
    self.clickHandler = clickHandler;
    
    [[attachView superview] addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(attachView.mas_left);
        make.right.equalTo(attachView.mas_right);
        make.top.equalTo(attachView.mas_bottom);
        make.bottom.equalTo([attachView superview].mas_bottom).mas_offset(20);
    }];
    
    NSLog(@"%lu", (unsigned long)_historyType);
    [self testData];
    //    [HistoryDao queryStockHistoryType:_historyType historyData:^(NSArray *stocks) {
    //        if (stocks.count <= 0) {
    //            [self clearHistoryList];
    //            return ;
    //        }
    //
    //        self.dataSource = [NSMutableArray arrayWithArray:stocks];
    //        [_tableView reloadData];
    //    }];
}


- (BOOL)isHistoryListExits {
    
    if (_tableView)
        return YES;
    else
        return NO;
}

- (void)clearHistoryList {
    
    if ([self isHistoryListExits]) {
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        [self.dataSource removeAllObjects];
        self.clickHandler = nil;
    }
}


- (void)clickClearAction {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"  message:@"您确定要删除所有历史记录吗？" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    [alert show];
}

#pragma mark - Properties

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        [_tableView registerClass:[VHistoryCell class] forCellReuseIdentifier:kStockHistoryCellIdentifier];
        
        _tableView.tableHeaderView = ({
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30.0f)];
            headerView.backgroundColor = [UIColor whiteColor];
            
            UILabel *serialLabel=[[UILabel alloc] init];
            serialLabel.textAlignment = NSTextAlignmentLeft;
            serialLabel.font=[UIFont systemFontOfSize:14.0];
            serialLabel.textColor = [UIColor darkGrayColor];
            serialLabel.text = @"以下为历史查询记录";
            [headerView addSubview:serialLabel];
            
            [serialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(headerView);
                make.left.mas_equalTo(headerView).offset(18);
                make.size.mas_equalTo(CGSizeMake(300, 30));
            }];
            headerView;
        });
        
        _tableView.tableFooterView = ({
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44.0f)];
            footerView.backgroundColor = [UIColor whiteColor];
            
            UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [clearBtn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
            clearBtn.titleLabel.font = [UIFont systemFontOfSize:17];
            [clearBtn addTarget:self action:@selector(clickClearAction) forControlEvents:UIControlEventTouchUpInside];
            [footerView addSubview:clearBtn];
            [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(footerView);
                make.height.mas_equalTo(44);
            }];
            footerView;
        });
        
    }
    return _tableView;
}


#pragma mark UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *containView = [[UIView alloc] init];
//    containView.backgroundColor = [UIColor whiteColor];
//
//    UILabel *serialLabel=[[UILabel alloc] init];
//    serialLabel.textAlignment = NSTextAlignmentLeft;
//    serialLabel.font=[UIFont systemFontOfSize:14.0];
//    serialLabel.textColor = [UIColor darkGrayColor];
//    serialLabel.text = @"以下为历史查询记录";
//    [containView addSubview:serialLabel];
//
//    [serialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(containView);
//        make.left.mas_equalTo(containView).offset(18);
//        make.width.mas_equalTo(@(300));
//        make.height.mas_equalTo(@(30));
//    }];
//
//    return containView;
//}


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//    UIView *footerView = [[UIView alloc] init];
//    footerView.frame = CGRectMake(0, 0, 0, 60);
//    UIButton * clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [clearBtn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
//    clearBtn.titleLabel.font = [UIFont systemFontOfSize:17];
//    [clearBtn addTarget:self action:@selector(clickClearAction) forControlEvents:UIControlEventTouchUpInside];
//    [footerView addSubview:clearBtn];
//    self.tableView.tableFooterView = footerView;
//
//    [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(footerView);
//        make.height.mas_equalTo(44);
//    }];
//
//    return footerView;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:kStockHistoryCellIdentifier];
    
    cell.model = self.dataSource[indexPath.row];
    cell.clickHandler = ^(){

    };
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    VHistoryCell *cell = (VHistoryCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (self.clickHandler) {
        self.clickHandler(self.dataSource[indexPath.row]);
    }
    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.attachView.superview endEditing:YES];
}

#pragma mark --UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        
        [self clearHistoryList];
        // 清除数据库中所有数据
        //        [HistoryDao deleteAllStockHistoryType:_historyType completion:^(BOOL success) {
        //
        //        }];
        
    }else if (buttonIndex == 1) {
        return;
    }
}



@end
