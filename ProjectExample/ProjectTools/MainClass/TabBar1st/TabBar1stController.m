//
//  TabBar1stController.m
//  ProjectTools
//
//  Created by Vols on 2015/10/31.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "TabBar1stController.h"

#import "VSearchViewController.h"
#import "VTitleCCell.h"

@interface TabBar1stController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  * collectionView;
@property (nonatomic, strong) NSArray           * dataSource;

@end

@implementation TabBar1stController


#pragma mark - View Lifecycle

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
    _dataSource = @[@"定位模块"];

}

- (void)configureViews {
    self.titleLabel.text = @"功能模块";
    [self.view addSubview:self.collectionView];

}

#pragma mark - Actions



#pragma mark - Properties

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kSCREEN_SIZE.width/2.0-60, 40);
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flowLayout.minimumLineSpacing = 2;
        flowLayout.minimumInteritemSpacing = 2;
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height-64-44)  collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[VTitleCCell class] forCellWithReuseIdentifier:kTitleCCellIdentifier];
    }
    return _collectionView;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VTitleCCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTitleCCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[VTitleCCell alloc] init];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    [cell layoutIfNeeded];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"当前选中行%ld", indexPath.row);
    
}


#pragma mark - Helpers

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
