//
//  VGuidePage.h
//  ProjectTools
//
//  Created by Vols on 2015/2/17.
//  Copyright © 2015年 Vols. All rights reserved.
//

/****************************
 *  用View实现最简单的引导图
 *
 *
 ****************************/

#import <UIKit/UIKit.h>

typedef void (^GuidePageNoParmaBlock)();

@interface VGuidePage : UIView

@property (nonatomic, strong) NSArray *imageDatas;
@property (nonatomic,   copy) GuidePageNoParmaBlock clickHandler;

+ (instancetype)guidePageWithImages:(NSArray *)imageDatas;

- (void)showInWindowWithClickHandler:(GuidePageNoParmaBlock)clickHandler;
- (void)showInView:(UIView *)superView clickHandler:(GuidePageNoParmaBlock)clickHandler;

@end
