//
//  MainTabBarController.m
//  ProjectTools
//
//  Created by Vols on 2016/10/31.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "MainTabBarController.h"

#define kClassKey   @"kClassKey"
#define kTitleKey   @"kTitleKey"
#define kImgKey     @"kImgKey"
#define kSelImgKey  @"kSelImgKey"


@interface MainTabBarController ()

@end

@implementation MainTabBarController

+ (MainTabBarController *) sharedMainController {
    static MainTabBarController * instancedMainController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instancedMainController = [[MainTabBarController alloc] init];
    });
    return instancedMainController;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"Example1ViewController",
                                   kTitleKey  : @"One",
                                   kImgKey    : @"icon_homePage_default",
                                   kSelImgKey : @"icon_homePage_selected"},
                                 
                                 @{kClassKey  : @"Example2ViewController",
                                   kTitleKey  : @"Two",
                                   kImgKey    : @"icon_search_default",
                                   kSelImgKey : @"icon_search_selected"},
                                 
                                 @{kClassKey  : @"Example3ViewController",
                                   kTitleKey  : @"Three",
                                   kImgKey    : @"icon_my_default",
                                   kSelImgKey : @"icon_my_selected"} ];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
