//
//  TabBar3stController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "TabBar2stController.h"

#import "VShowWeb1Controller.h"
#import "V2ShowWebViewController.h"
#import "VSearchViewController.h"
#import "VTitleCCell.h"

#import "VGuidePage.h"
#import "VLaunchAdPage.h"
#import "VVideoPage.h"
#import "VVideoPageController.h"

#import "VHelpCenterController.h"

#import "VUIHelper.h"

@interface TabBar2stController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  * collectionView;
@property (nonatomic, strong) NSArray           * dataSource;


@end

@implementation TabBar2stController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self configureViews];
    
}

- (void)initData {
    _dataSource = @[@"广告页模块", @"视频启动页模块", @"引导页", @"web模块", @"历史记录模块", @"帮助中心"];
}

- (void)configureViews {
    self.view.backgroundColor = kRGB(248, 192, 86);
    self.titleLabel.text = @"UI模块";
    
    [self.view addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}





#pragma mark - Properties

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kSCREEN_SIZE.width/2.0-60, 40);
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        flowLayout.minimumLineSpacing = 20;  // 行间隔
        flowLayout.minimumInteritemSpacing = 20;
//                flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kRGB(248, 192, 86);
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
            [self showLaunchAdPage];
            break;
            
        case 1:
            [self showVideoPage];
            break;
            
        case 2:
            [self showGuidePage];
            break;

        case 3:
            [self showWebPage];
            break;
        
        case 4:
            [self searchHistoryAction];
            break;
            
        case 5:
            [self showHelpCenterPage];
            break;

            
        default:
            break;
    }
}


#pragma mark - Actions

- (void)showGuidePage {
    
    NSArray *imageArray = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];
    VGuidePage *guidePage = [VGuidePage guidePageWithImages:imageArray];
    [guidePage showInWindowWithClickHandler:^{
        
    }];
}

- (void)showLaunchAdPage {
    
    NSString *imgURLString = @"http://imgstore.cdn.sogou.com/app/a/100540002/714860.jpg";
    VLaunchAdPage * launchAd = [VLaunchAdPage launchPageWithImageURL:imgURLString];
    [launchAd showInWindowWithAnimationType:LaunchAnimationTypeNone clickHandler:^() {
        [launchAd dismissAnimation];
        
        VShowWeb1Controller * webVC = [[VShowWeb1Controller alloc] init];
        webVC.theURL = @"https://www.baidu.com";
        webVC.theTitle = @"百度";
        webVC.backButtonHidden = NO;
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:webVC];
        [self.view.window.rootViewController presentViewController:navController animated:YES completion:nil];
    }];
}

- (void)showVideoPage {
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"qidong"ofType:@"mp4"];
    if (filePath == nil) {
        NSLog(@"路径不能为空");
        return;
    }
    
    VVideoPage * videoPage = [VVideoPage videoPageWithVideoURL:[NSURL fileURLWithPath:filePath]];
    [videoPage showInWindowWithAnimationType:VideoTransAnimationTypeNone clickHandler:^{
        NSLog(@"进入应用");
    }];
}

- (void)showWebPage {
    V2ShowWebViewController *webView = [[V2ShowWebViewController alloc] init];
    [webView loadWebURLSring:@"http://www.sina.com"];
    webView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)searchHistoryAction {
    VSearchViewController * stockSearchVC = [[VSearchViewController alloc] init];
    stockSearchVC.refreshStockListHandler = ^(){ };
    UINavigationController * navControl = [[UINavigationController alloc]initWithRootViewController:stockSearchVC];
    [self presentViewController:navControl animated:YES completion:nil];
}

- (void)showHelpCenterPage {
    VHelpCenterController * controller = [[VHelpCenterController alloc] init];
    UINavigationController * navControl = [[UINavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navControl animated:YES completion:nil];
}

#pragma mark - Helpers

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
