//
//  VHelpCenterController.m
//  ProjectTools
//
//  Created by Vols on 2016/2/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VHelpCenterController.h"
#import "VAnswerCell.h"
#import "VHelpHeaderView.h"

@interface VHelpCenterController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton  * backButton;

@property (nonatomic, strong) UITableView                   * tableView;
@property (nonatomic, strong) NSMutableArray<VHelpModel *>  * dataSource;
@property (nonatomic, assign) CGSize textSize;

@end

@implementation VHelpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    self.view.backgroundColor = [UIColor purpleColor];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];

    [self initData];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


- (void)initData {
    _dataSource = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i ++) {
        VHelpModel * model = [[VHelpModel alloc] init];
        model.questionString = @"问题";
        model.answerString = @"答案";
        model.opened = NO;
        [_dataSource addObject:model];
    }
}


#pragma mark - Properties

- (UITableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[VAnswerCell class] forCellReuseIdentifier:kAnswerCellIdentifier];
        _tableView.estimatedRowHeight = 80;      //预估行高 可以提高性能
        _tableView.sectionHeaderHeight = 50;
        _tableView.tableFooterView = [UIView new];

    }
    return _tableView;
}

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 44, 44);
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setTitle:@"X" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    VHelpModel *model = self.dataSource[section];
    return model.isOpened ? 1 : 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = kAnswerCellIdentifier;
    
    VAnswerCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
//    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    VHelpModel *model = self.dataSource[indexPath.section];
    cell.model = model;
    
    self.textSize = [self getLabelSizeFortextFont:[UIFont systemFontOfSize:15] textLabel:model.answerString];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.textSize.height + 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak __typeof(self)weakSelf = self;
    
    VHelpHeaderView *headView = [VHelpHeaderView headerViewWithTableView:tableView];
    headView.clickHandler = ^(){
        [weakSelf.tableView reloadData];
    };
    headView.helpModel = self.dataSource[section];
    
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


- (CGSize)getLabelSizeFortextFont:(UIFont *)font textLabel:(NSString *)text{
    NSDictionary * totalMoneydic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize totalMoneySize =[text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-16,1000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:totalMoneydic context:nil].size;
    return totalMoneySize;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
