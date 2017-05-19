//
//  VScrollMenuController.m
//  VariousMenu
//
//  Created by Vols on 2017/2/8.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VScrollMenuController.h"

#import "VSlideMenuView.h"
#import "ExampleViewController.h"

@interface VScrollMenuController ()<UIScrollViewDelegate, SlideMenuViewDelegate>

@property (nonatomic, strong) UIScrollView *mainScrollView;

@property (nonatomic, weak) VSlideMenuView *slideView;

@end

@implementation VScrollMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"话题",@"问吧",@"关注"];
    self.viewControllers = @[[ExampleViewController new],[ExampleViewController new],[ExampleViewController new]];
    
    [self initNavBar];
    
    [self addChildViewControllers];
    
    [self configureViews];
    [self addContentViews];
}

- (void)initNavBar {
    
    VSlideMenuView *slideView = [[VSlideMenuView alloc] initWithFrame:CGRectMake(0, 0, 200, 30) titles:self.titles];
    slideView.delegate = self;
    slideView.borderColor = [UIColor whiteColor];
    slideView.titleNormalColor = [UIColor whiteColor];
//    slideView.titleSelectedColor = self.navigationController.navigationBar.barTintColor;
    slideView.titleSelectedColor = kRGBHex(0xDC4B53);
    
    self.navigationItem.titleView = slideView;
    self.slideView = slideView;
}

- (void)configureViews {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.mainScrollView];
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addChildViewControllers {
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addChildViewController:vc];
    }];
}

- (void)addContentViews {
    UIView *horizontalContainerView = [[UIView alloc]init];
    [_mainScrollView addSubview:horizontalContainerView];
    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainScrollView);
        make.height.equalTo(_mainScrollView);
    }];
    
    // 过渡视图添加子视图
    UIView *previousView = nil;
    for (int i = 0; i <_viewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        UIView * view = vc.view;
        //添加到父视图，并设置过渡视图中子视图的约束
        [horizontalContainerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.bottom.equalTo(horizontalContainerView);
            make.width.equalTo(_mainScrollView);
            
            if (previousView) {
                make.left.mas_equalTo(previousView.mas_right);
            }
            else {
                make.left.mas_equalTo(0);
            }
        }];
        
        previousView = view;
    }
    
    // 设置过渡视图的右距（此设置将影响到scrollView的contentSize）
    [horizontalContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(previousView.mas_right);
    }];
}


#pragma mark - Properties

- (UIScrollView *) mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

#pragma mark - VSlideMenuViewDelegate
- (void)slideView:(VSlideMenuView *)slideView didSelectedAtIndex:(NSInteger)index {
    
    [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.bounds.size.width * index, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slideView changeColorWithOffsetX:scrollView.contentOffset.x width:scrollView.bounds.size.width];
}

@end
