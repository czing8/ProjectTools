//
//  VGuidePage.m
//  ProjectTools
//
//  Created by Vols on 2015/2/17.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VGuidePage.h"

@interface VGuidePage () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  * scrollView;
@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) UIButton      * enterButton;

@end

@implementation VGuidePage

+ (instancetype)guidePageWithImages:(NSArray *)imageDatas {
    VGuidePage *guidePage = [[VGuidePage alloc] init];
    [guidePage setImageDatas:imageDatas];
    return guidePage;
}

- (instancetype)init {
    self = [super init];
    if (self)  {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (void)initContentView {
    if (_imageDatas.count <= 0) return ;
    
    _pageControl.numberOfPages = _imageDatas.count;
    _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * _imageDatas.count, [[UIScreen mainScreen] bounds].size.height);
    for (int i = 0; i < _imageDatas.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageDatas[i]]];
        imgView.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width * i, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        [self.scrollView addSubview:imgView];
        
        if (i == _imageDatas.count - 1) {
            [imgView addSubview:self.enterButton];
            imgView.userInteractionEnabled = YES;
        }
    }
}


- (void)showInWindowWithClickHandler:(GuidePageNoParmaBlock)clickHandler {
    [self showInView:[[UIApplication sharedApplication].delegate window] clickHandler:clickHandler];
}

- (void)showInView:(UIView *)superView clickHandler:(GuidePageNoParmaBlock)clickHandler {
    if (superView == nil) {
        NSLog(@"superView can't nil");
        return;
    }
    
    self.clickHandler = clickHandler;

    superView.hidden = NO;
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
}

- (void)dismissAction {
    [UIView animateWithDuration:0.8 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)setImageDatas:(NSArray *)imageDatas {
    _imageDatas = imageDatas;
    [self initContentView];
}


#pragma mark - Action
- (void)clickAction:(UIButton *)sender {
    [self dismissAction];
    
    if (_clickHandler) {
        _clickHandler();
    }
}


#pragma mark - Properities
- (UIScrollView *) scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl =
        [[UIPageControl alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 30, [[UIScreen mainScreen] bounds].size.width, 10)];
        _pageControl.currentPage = 0;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (UIButton *) enterButton {
    if (_enterButton == nil) {
        _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _enterButton.frame = CGRectMake(24, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 48, 48);
        _enterButton.layer.borderWidth = 1;
        _enterButton.layer.cornerRadius = 24;
        _enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _enterButton.layer.masksToBounds = YES;
        [_enterButton setTitle:@"进入应用" forState:UIControlStateNormal];
        _enterButton.tintColor = [UIColor whiteColor];
        _enterButton.backgroundColor = [UIColor clearColor];
        [_enterButton addTarget:self
                         action:@selector(clickAction:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _enterButton;
}


#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _pageControl.currentPage = (_scrollView.contentOffset.x + [[UIScreen mainScreen] bounds].size.width / 2) / [[UIScreen mainScreen] bounds].size.width;
}

@end
