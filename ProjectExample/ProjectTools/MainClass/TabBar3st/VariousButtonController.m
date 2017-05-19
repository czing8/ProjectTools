//
//  VariousButtonController.m
//  ProjectTools
//
//  Created by Vols on 2016/2/17.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VariousButtonController.h"

#import "VerifyCodeButton.h"
#import "VExtendTextButton.h"

@interface VariousButtonController ()

@end

@implementation VariousButtonController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureViews];
}

- (void)configureViews {
    [self addVerifyCodeButton];
    [self addExtendTextButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addVerifyCodeButton {
    VerifyCodeButton* btn  = [VerifyCodeButton buttonWithFrame:CGRectMake(20, 20, 120, 40) clickHandler:^(VerifyCodeButton *btn) {
        // 向服务器请求验证码
        
    }];
    [self.view addSubview:btn];
}


- (void)addExtendTextButton{
    
    NSArray * buttonImages = @[@"bowl", @"location"];
    NSArray * buttonTitles = @[@"行动", @"位置"];
    
    for (int i = 0; i < 2; i ++) {
        VExtendTextButton * tagButton = [[VExtendTextButton alloc] init];
        
        tagButton.frame = CGRectMake(20, 100+30*i, 80, 30);
        //        tagButton.center = (CGPoint){self.view.center.x, 60+50*i};
        tagButton.tag = 2000 + i;
        tagButton.backgroundColor = [UIColor clearColor];
        [tagButton setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        [tagButton setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [tagButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [tagButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.view addSubview:tagButton];
    }
}


#pragma mark - Actions

- (void)clickAction:(id)sender{
    NSLog(@"%s", __FUNCTION__);
}





@end
