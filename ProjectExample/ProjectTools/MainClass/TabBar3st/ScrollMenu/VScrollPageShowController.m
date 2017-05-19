//
//  VScrollPageShowController.m
//  ProjectTools
//
//  Created by Vols on 2017/3/13.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "VScrollPageShowController.h"
#import "VScroll1PageController.h"
#import "VScroll2PageController.h"
#import "VScrollMenuController.h"

@interface VScrollPageShowController ()


@end

@implementation VScrollPageShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
    
    [self configureViews];
    
}

- (void)configureViews {
    NSArray * titles = @[@"不等宽", @"等宽", @"导航栏"];
    for (int i = 0; i < 3; i ++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(0, 0, 100, 30);
        button.center = CGPointMake(self.view.center.x, 100+i*80);
        [button addTarget:self action:@selector(event_clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}


- (void)event_clickAction:(UIButton *)sender {
    if (sender.tag - 100 == 0) {
        [self.navigationController pushViewController:[[VScroll1PageController alloc] init] animated:YES];

    }
    else if (sender.tag - 100 == 1) {
        [self.navigationController pushViewController:[[VScroll2PageController alloc] init] animated:YES];

    }
    else if (sender.tag - 100 == 2) {
        [self.navigationController pushViewController:[[VScrollMenuController alloc] init] animated:YES];
        
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
