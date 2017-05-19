//
//  VScroll1PageController.m
//  ProjectControls
//
//  Created by Vols on 2014/11/14.
//  Copyright © 2014年 vols. All rights reserved.
//

#import "VScroll1PageController.h"
#import "VScroll1Page.h"

@interface VScroll1PageController () <VScroll1PageDelegate>

@property (nonatomic, strong) VScroll1Page * scroll1Menu;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation VScroll1PageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];

    [self initData];
    [self configureViews];

}


- (void)initData {
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 12; i ++) {
        
        UIViewController * vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor randomColor];
        vc.title = i%2?[NSString stringWithFormat:@"title：%d", i]: [NSString stringWithFormat:@"the title：%d", i];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, 30)];
        label.center = CGPointMake(vc.view.center.x, 100);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"VC：%d", i];
        [vc.view addSubview:label];
        [_dataSource addObject:vc];
        [self addChildViewController:vc];

    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    _scroll1Menu.frame = self.view.bounds;
    
    
}

- (void)configureViews {
    
    self.title = @"滑动菜单";
    
    [self.view addSubview:self.scroll1Menu];
    self.scroll1Menu.viewArray = self.dataSource;
}

#pragma mark - properties

- (VScroll1Page *)scroll1Menu {
    if (_scroll1Menu == nil) {
        _scroll1Menu = [[VScroll1Page alloc] initWithFrame:self.view.bounds];
        _scroll1Menu.delegate = self;
    }
    return _scroll1Menu;
}


- (void)scrollPage:(VScroll1Page *)view didSelectPageAtIndex:(NSUInteger)index{
    NSLog(@"didSelectPageAtIndex:%lu",(unsigned long)index);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
