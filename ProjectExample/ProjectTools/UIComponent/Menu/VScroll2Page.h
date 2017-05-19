//
//  VScroll2Page.h
//  ProjectControls
//
//  Created by Vols on 2016/11/16.
//  Copyright © 2016年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VScroll2PageDelegate;

/*
 *  等宽按钮
 */
@interface VScroll2Page : UIView {
    NSMutableArray * _viewArray;
}

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, weak) id<VScroll2PageDelegate> delegate;

@property (nonatomic, strong) UIColor *tabItemNormalColor;
@property (nonatomic, strong) UIColor *tabItemSelectedColor;
@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, strong) UIImage *shadowImage;

- (void)reloadData;         //数据源更新后  刷新

@end


@protocol VScroll2PageDelegate <NSObject>

@optional
- (void)scrollPage:(VScroll2Page *)view didSelectPageAtIndex:(NSUInteger)index;

@end
