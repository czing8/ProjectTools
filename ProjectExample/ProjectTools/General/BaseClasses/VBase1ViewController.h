//
//  VBase1ViewController.h
//  PrejectTools
//
//  Created by Vols on 2016/10/25.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBase1ViewController : UIViewController

@property (nonatomic, strong) UILabel *titleLabel;    //导航栏标题
@property (nonatomic, strong) UILabel *errorLabel;    //错误信息展示


- (void)setNavBackBarButton;

- (void)setLeftBarButtonWithImage:(NSString *)imageStr;
- (void)setRightBarButtonWithImage:(NSString *)imageStr;


- (void)leftBarButtonClicked:(UIButton *)button;
- (void)rightBarButtonClicked:(UIButton *)button;

@end
