//
//  VBase1ViewController.h
//  PrejectTools
//
//  Created by Vols on 2016/10/25.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CallBackBlock)(void);

@interface VBase1ViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLabel;    //导航栏标题

@property (nonatomic, readwrite, copy) CallBackBlock dissmissCallBack;
@property (nonatomic, readwrite, copy) CallBackBlock popCallBack;


- (void)initData;
- (void)configureViews;


- (void)setLeftBarButtonWithImage:(NSString *)imageStr;
- (void)setRightBarButtonWithImage:(NSString *)imageStr;

- (void)leftBarButtonClicked:(UIButton *)button;
- (void)rightBarButtonClicked:(UIButton *)button;

@end
