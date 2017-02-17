//
//  V2MainTabBarController.m
//  ProjectTools
//
//  Created by Vols on 2015/12/8.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "V2MainTabBarController.h"

#define kClassKey   @"kClassKey"
#define kTitleKey   @"kTitleKey"
#define kImgKey     @"kImgKey"
#define kSelImgKey  @"kSelImgKey"

@interface V2MainTabBarController ()

@end

@implementation V2MainTabBarController


+ (V2MainTabBarController *) sharedMainController {
    static V2MainTabBarController * instancedMainController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instancedMainController = [[V2MainTabBarController alloc] init];
    });
    return instancedMainController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBarUIs];
    [self dislplayTabBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //设置中间按钮不受TintColor影响
    NSArray *items =  self.tabBar.items;
    UITabBarItem *btnAdd = items[1];
    btnAdd.image = [btnAdd.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    btnAdd.selectedImage = [btnAdd.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)dislplayTabBar {
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"Example1ViewController",
                                   kTitleKey  : @"直播",
                                   kImgKey    : @"icon_homePage_default",
                                   kSelImgKey : @"icon_homePage_selected"},
                                 
                                 @{kClassKey  : @"Example2ViewController",
                                   kTitleKey  : @"",
                                   kImgKey    : @"btn_card",
                                   kSelImgKey : @"btn_card"},
                                 
                                 @{kClassKey  : @"Example3ViewController",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"icon_my_default",
                                   kSelImgKey : @"icon_my_selected"}];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //[item setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
}


- (void)configureTabBarUIs {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -8, self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    [imageView setImage:[UIImage imageNamed:@"tabbar_bg"]];
    [imageView setContentMode:UIViewContentModeCenter];
    [self.tabBar insertSubview:imageView atIndex:0];
    //覆盖原生Tabbar的上横线
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    //设置TintColor
    UITabBar.appearance.tintColor = [UIColor orangeColor];
}


- (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
