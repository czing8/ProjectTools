//
//  V2ShowWebViewController.h
//  ProjectTools
//
//  Created by Vols on 2015/12/9.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface V2ShowWebViewController : UIViewController


/*
 *  加载URL方式
 */
- (void)loadWebURLSring:(NSString *)string;

/*
 *  加载本地HTML方式
 */
- (void)loadHTMLString:(NSString *)string;


- (void)postWebURLSring:(NSString *)string postData:(NSString *)postData;

@end
