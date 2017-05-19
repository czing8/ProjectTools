//
//  VScrollMenuShowController.m
//  ProjectTools
//
//  Created by Vols on 2017/3/13.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "VScrollMenuShowController.h"
#import "VScrollMenuView.h"
#import "VToolBar.h"
#import "V2ToolBar.h"

@interface VScrollMenuShowController ()<VScrollMenuViewDelegate,VToolBarDelegate>

@property (nonatomic, strong) VScrollMenuView * scrollMenu;

@property (nonatomic, strong) VToolBar      * toolBar1;
@property (nonatomic, strong) V2ToolBar     * toolBar2;

@end

@implementation VScrollMenuShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    
    [self setupScrollMenuView];
    [self setupToolBarMenu];
}

- (void)setupScrollMenuView {
    
    _scrollMenu = [[VScrollMenuView alloc]initWithTitles:@[@"菜单1", @"菜单2", @"菜单3"] layoutStyle:VScrollMenuLayoutStyleInScreen];
    _scrollMenu.titleFont = [UIFont systemFontOfSize:15];
    [self.view addSubview:_scrollMenu];
    [_scrollMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    _scrollMenu.delegate = self;
}


- (void)setupToolBarMenu{
    
    NSArray * titleArray = @[@"Menu 1", @"Menu 2", @"Menu 3", @"Menu 4"];
    _toolBar1 = [[VToolBar alloc] initWithTitles:titleArray];
    _toolBar1.delegate = self;
    _toolBar1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_toolBar1];
    
    [_toolBar1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toolBar1.superview).offset(100);
        make.left.width.equalTo(_toolBar1.superview);
        make.height.mas_equalTo(@(40));
    }];
    
    _toolBar2 = [[V2ToolBar alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 40)];
    _toolBar2.titleArray = titleArray;
    _toolBar2.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_toolBar2];
}


#pragma mark - ScrollMenuDelegate

- (void)scrollMenu:(VScrollMenuView *)scrollMenu didSelectedIndex:(NSInteger)index {
    
}


#pragma mark - VSegmentMenu Delegate

- (void)toolBar:(VToolBar *)toolBar didSelectMenuAtIndex:(NSUInteger)index {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
