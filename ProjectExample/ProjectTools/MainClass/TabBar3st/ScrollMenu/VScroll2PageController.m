//
//  VScroll2PageController.m
//  ProjectControls
//
//  Created by Vols on 2015/11/16.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "VScroll2PageController.h"
#import "VScroll2Page.h"

@interface VScroll2PageController () <VScroll2PageDelegate>

@property (nonatomic, strong) VScroll2Page * scroll2Menu;
@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation VScroll2PageController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];

    [self initData];
    [self configureViews];
}


- (void)initData {
    _dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 2; i ++) {
        
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
    
    _scroll2Menu.frame = self.view.bounds;
}

- (void)configureViews {
    
    self.title = @"滑动菜单";
    
    [self.view addSubview:self.scroll2Menu];
    self.scroll2Menu.viewArray = self.dataSource;
}

#pragma mark - properties

- (VScroll2Page *)scroll2Menu {
    if (_scroll2Menu == nil) {
        _scroll2Menu = [[VScroll2Page alloc] initWithFrame:self.view.bounds];
        _scroll2Menu.delegate = self;
    }
    return _scroll2Menu;
}


- (void)scrollMenu:(VScroll2Page *)view didSelectPageAtIndex:(NSUInteger)index{
    
    NSLog(@"didSelectPageAtIndex:%lu",(unsigned long)index);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
