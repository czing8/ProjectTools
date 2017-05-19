//
//  V2EffectsButton.m
//  ProjectTools
//
//  Created by Vols on 2017/2/17.
//  Copyright © 2017年 Vols. All rights reserved.
//

#import "V2EffectsButton.h"

@implementation V2EffectsButtonParams

- (instancetype)init {
    if (self = [super init]) {
        _allowRandomColor   = false;
        _animDuration       = 1;
        _bigShineColor      = kRGB(255, 102, 102);
        _enableFlashing     = false;
        _shineCount = 7;
        _shineTurnAngle = 20;
        _shineDistanceMultiple = 1.5;
        _smallShineOffsetAngle = 20;
        _smallShineColor = [UIColor grayColor];
        _shineSize = 0;
        _colorRandom        = @[kRGB(255, 255, 153),
                               kRGB(255, 204, 204),
                               kRGB(153, 102, 153),
                               kRGB(255, 102, 102),
                               kRGB(255, 255, 102),
                               kRGB(244, 67, 54),
                               kRGB(102, 102, 102),
                               kRGB(204, 204, 0),
                               kRGB(102, 102, 102),
                                kRGB(153, 153, 51)];
    }
    return self;
}

@end

@implementation V2EffectsButton

@end



@interface VShineLayer : CALayer <CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer * shapeLayer;

@end


@implementation VShineLayer

- (instancetype)init {
    if (self = [super init]) {
        _shapeLayer.fillColor = [UIColor whiteColor].CGColor;
//        _shapeLayer.strokeColor= 
    }
    return self;
}

@end






