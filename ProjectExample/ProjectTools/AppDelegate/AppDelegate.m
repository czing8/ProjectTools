//
//  AppDelegate.m
//  PrejectTools
//
//  Created by Vols on 2015/10/25.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "V2MainTabBarController.h"
#import "LoginViewController.h"

#import "UIImage+VAdd.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)enterLoginUI {
    LoginViewController *vc = [[LoginViewController alloc] init];
    self.window.rootViewController = vc;
}


- (void)enterMainUI {
    //可以加引导页，提示操作等
//    NSNumber *has = [[NSUserDefaults standardUserDefaults] objectForKey:@"HasReadUserProtocol"];
//    if (!has || !has.boolValue) {
//        UserProtocolViewController *vc = [[UserProtocolViewController alloc] init];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        self.window.rootViewController = nav;
//        return;
//    }
    
    self.window.rootViewController = [MainTabBarController sharedMainController];
//    self.window.rootViewController = [V2MainTabBarController sharedMainController];
}


//配置app控件全局外观
- (void)configAppearance {
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSShadowAttributeName:shadow,
                                                           NSFontAttributeName:[UIFont systemFontOfSize:16]
                                                           }];
    
    [[UILabel appearance] setBackgroundColor:[UIColor clearColor]];
    [[UILabel appearance] setTextColor:[UIColor grayColor]];
    
    
    [[UIButton appearance] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [[UITextField appearance] setTintColor:[UIColor orangeColor]];//设置UITextField的光标颜色
    [[UITextView appearance] setTintColor:[UIColor orangeColor]];//设置UITextView的光标颜色
    [[UISearchBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:0 barMetrics:UIBarMetricsDefault];
}

//配置app参数，三方sdk参数
- (void)configAppLaunch {
    
    
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [self configAppearance];

    [self configAppLaunch];
//    [self enterLoginUI];      //必须登录的，走这一步，登录完成后 调用enterMainUI；
    [self enterMainUI];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
