//
//  TabBar3stController.m
//  ProjectTools
//
//  Created by Vols on 2015/10/31.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "TabBar3stController.h"
#import "UIColor+VAdd.h"
#import "VShowWeb1Controller.h"
#import "VariousAnimationController.h"
#import "VariousButtonController.h"
#import "VariousSwitchController.h"
#import "VScrollMenuShowController.h"
#import "VScrollPageShowController.h"
#import "VTitleCCell.h"

#import "VUIHelper.h"

@interface TabBar3stController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  * collectionView;
@property (nonatomic, strong) NSArray           * dataSource;

@end

@implementation TabBar3stController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self configureViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor randomColor];
}


- (void)initData {
    _dataSource = @[@"Various Animation", @"Various Button", @"Scroll Menu", @"Scroll Page", @"Various Switch"];
}

- (void)configureViews {
    self.titleLabel.text = @"控件";
    
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Properties

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kSCREEN_SIZE.width/2.0-40, 40);
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
        flowLayout.minimumLineSpacing = 20;  // 行间隔
        flowLayout.minimumInteritemSpacing = 2;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[VTitleCCell class] forCellWithReuseIdentifier:kTitleCCellIdentifier];
    }
    return _collectionView;
}


#pragma mark - UICollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VTitleCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTitleCCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self pushNextViewController:[VariousAnimationController class]];
            break;
            
        case 1:
            [self pushNextViewController:[VariousButtonController class]];
            break;
            
        case 2:
            [self pushNextViewController:[VScrollMenuShowController class]];
            break;
            
        case 3:
            [self pushNextViewController:[VScrollPageShowController class]];
            break;

        case 4:
            [self pushNextViewController:[VariousSwitchController class]];
            break;

        default:
            break;
    }
}

#pragma mark - Actions
//- (void)showAnimationPage {
//    VariousAnimationController * controller = [[VariousAnimationController alloc] init];
//    controller.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//- (void)showButtonPage {
//    VariousButtonController * buttonVC = [[VariousButtonController alloc] init];
//    buttonVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:buttonVC animated:YES];
//}
//
//- (void)showSwitchPage {
//    VariousSwitchController * switchVC = [[VariousSwitchController alloc] init];
//    switchVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:switchVC animated:YES];
//}


#pragma mark - helper

- (void)pushNextViewController:(Class)class {
    UIViewController * controller = [[class alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
