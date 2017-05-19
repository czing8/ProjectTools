//
//  V2EffectsButton.h
//  ProjectTools
//
//  Created by Vols on 2017/2/17.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface V2EffectsButtonParams : NSObject

@property (nonatomic, assign) BOOL      allowRandomColor;        // shine是否随机颜色
@property (nonatomic, assign) double    animDuration;          // shine动画时间，秒
@property (nonatomic, strong) UIColor   * bigShineColor;        // 大Shine的颜色
@property (nonatomic, assign) BOOL      enableFlashing;          // 是否需要Flash效果
@property (nonatomic, assign) int       shineCount;    // shine的个数
@property (nonatomic, assign) float     shineTurnAngle; // shine的扩散的旋转角度

@property (nonatomic, assign) float     shineDistanceMultiple;  // shine的扩散的范围的倍数
@property (nonatomic, assign) float     smallShineOffsetAngle;  // 小shine与大shine之前的角度差异
@property (nonatomic, strong) UIColor   *  smallShineColor;  // shine的扩散的范围的倍数
@property (nonatomic, assign) float     shineSize;  // shine的大小
@property (nonatomic, strong) NSArray   *  colorRandom;  // shine的扩散的范围的倍数

@end


@interface V2EffectsButton : UIControl

@end
