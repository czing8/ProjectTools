//
//  StarRatingView.h
//  StarRatingView
//
//  Created by Vols on 16/3/2.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CurRatingResultBlock)(float ratingValue);

@interface StarRatingView : UIView

@property (nonatomic, copy) CurRatingResultBlock ratingResult;

@property (nonatomic, assign) CGFloat   scorePercent;       //得分值，范围为0--1，默认为1
@property (nonatomic, assign) BOOL      hasAnimation;       //是否允许动画，默认为NO
@property (nonatomic, assign) BOOL      allowIncompleteStar;//评分时是否允许不是整星，默认为NO
@property (nonatomic, assign) BOOL      onlyShow;           //是否为单纯的显示，默认为NO

- (instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars;

@end
