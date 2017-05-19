//
//  VEffectsButton.m
//  VEffectsButtonDemo
//
//  Created by Vols on 15/7/21.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "VEffectsButton.h"

@interface VEffectsButton ()

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, strong) CAShapeLayer * circleShape;
@property (nonatomic, strong) CAShapeLayer * circleMask;
@property (nonatomic, strong) CAShapeLayer * imageShape;

@property (nonatomic, strong) NSMutableArray * lines;

@property (nonatomic, strong) CAKeyframeAnimation   * circleTransform;
@property (nonatomic, strong) CAKeyframeAnimation   * circleMaskTransform;
@property (nonatomic, strong) CAKeyframeAnimation   * lineStrokeStart;
@property (nonatomic, strong) CAKeyframeAnimation   * lineStrokeEnd;
@property (nonatomic, strong) CAKeyframeAnimation   * lineOpacity;
@property (nonatomic, strong) CAKeyframeAnimation   * imageTransform;

@end

@implementation VEffectsButton

@synthesize selected = _selected;


- (id)initWithFrame:(CGRect)frame {
    UIImage * image = [UIImage imageNamed:@"star"];
    return [self initWithFrame:frame image:image];
}

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViewWithImage:image];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
     
    }
    
    return self;
}


//从SB、Xib加载时，会走initWithCoder初始化，然后才是 ViewDidLoad，so 在ViewDidLoad中初始化界面。

- (void)configureViewWithImage:(UIImage *)image {
    self.image = image;

    self.imageColorOn   = [UIColor colorWithRed:255/255 green:172/255.0 blue:51/255.0 alpha:1];
    self.imageColorOff  = [UIColor colorWithRed:136/255.0f green: 153/255.0f blue: 166/255.0f alpha:1.0];
    self.circleColor    = [UIColor colorWithRed:255/255 green:172/255.0 blue:51/255.0 alpha:1];
    self.lineColor      = [UIColor colorWithRed:250/255 green:120/255.0 blue:68/255.0 alpha:1];
    [self createLayers:_image];

    [self addTargets];
}


#pragma mark - setter/getter

- (void)setImageColorOn:(UIColor *)imageColorOn {
    _imageColorOn = imageColorOn;
    
    if (self.selected) {
        self.imageShape.fillColor = imageColorOn.CGColor;
    }
}


- (void)setImageColorOff:(UIColor *)imageColorOff {
    _imageColorOff = imageColorOff;
    
    if (!self.selected) {
        self.imageShape.fillColor = imageColorOff.CGColor;
    }
}


- (void)setCircleColor:(UIColor *)circleColor {
    _circleColor = circleColor;
    
    self.circleShape.fillColor = circleColor.CGColor;
}


- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    for (CAShapeLayer *line in self.lines) {
        line.strokeColor = lineColor.CGColor;
    }
}

- (void)setDuration:(double)duration{
    _duration = duration;
    
    self.circleTransform.duration = 0.333 * self.duration;
    self.circleMaskTransform.duration = 0.333 * self.duration;
    self.lineStrokeStart.duration = 0.6 * self.duration;
    self.lineStrokeEnd.duration = 0.6 * self.duration;
    self.lineOpacity.duration = 1.0 * self.duration;
    self.imageTransform.duration = 1.0 * self.duration;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        self.imageShape.fillColor = self.imageColorOn.CGColor;
    }
    else {
        [self deselect];
    }
}

- (BOOL)isSelected {
    return _selected;
}


#pragma mark - actions

- (void)addTargets {
    [self addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(touchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
}


- (void)touchDown:(id)sender {
    self.layer.opacity = 0.4;
}

- (void)touchUpInside:(id)sender {
    self.layer.opacity = 1.0;
    
    self.selected ? [self deselect] : [self select];
    
    if (self.clickHandle) {
        self.clickHandle();
    }
}

- (void)touchDragExit:(id)sender {
    self.layer.opacity = 1.0;
}

- (void)touchDragEnter:(id)sender {
    self.layer.opacity = 0.4;
}

- (void)touchCancel:(id)sender {
    self.layer.opacity = 1.0;
}


- (void)select {
    _selected = true;
    self.imageShape.fillColor = self.imageColorOn.CGColor;
    
    [CATransaction begin];
    
    [self.circleShape addAnimation:self.circleTransform forKey:@"transform"];
    [self.circleMask addAnimation:self.circleMaskTransform forKey:@"transform"];
    [self.imageShape addAnimation:self.imageTransform forKey:@"transform"];
    
    for (int i=0; i<5; i++) {
        [self.lines[i] addAnimation:self.lineStrokeStart forKey:@"strokeStart"];
        [self.lines[i] addAnimation:self.lineStrokeEnd forKey:@"strokeEnd"];
        [self.lines[i] addAnimation:self.lineOpacity forKey:@"opacity"];
    }
    
    [CATransaction commit];
}

- (void)deselect {
    _selected = false;
    self.imageShape.fillColor = self.imageColorOff.CGColor;
    
    // remove all animations
    [self.circleShape removeAllAnimations];
    [self.circleMask removeAllAnimations];
    [self.imageShape removeAllAnimations];
    [self.lines[0] removeAllAnimations];
    [self.lines[1] removeAllAnimations];
    [self.lines[2] removeAllAnimations];
    [self.lines[3] removeAllAnimations];
    [self.lines[4] removeAllAnimations];
}




#pragma mark - layers

- (void)createLayers:(UIImage *)image {
    
    self.layer.sublayers = nil;
    
    self.circleTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    self.circleMaskTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    self.lineStrokeStart = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    self.lineStrokeEnd = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    self.lineOpacity = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    self.imageTransform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    
    CGRect imageFrame = CGRectMake(self.frame.size.width / 2 - self.frame.size.width / 4, self.frame.size.height / 2 - self.frame.size.height / 4, self.frame.size.width / 2, self.frame.size.height / 2);
    
    CGPoint imgCenterPoint = CGPointMake(imageFrame.origin.x + imageFrame.size.width / 2, imageFrame.origin.y + imageFrame.size.height / 2);
    CGRect lineFrame = CGRectMake(imageFrame.origin.x - imageFrame.size.width / 4, imageFrame.origin.y - imageFrame.size.height / 4 , imageFrame.size.width * 1.5, imageFrame.size.height * 1.5);
    
    //===============
    // circle layer
    //===============
    _circleShape        = [CAShapeLayer layer];
    _circleShape.bounds = imageFrame;
    _circleShape.position = imgCenterPoint;
    _circleShape.path = [UIBezierPath bezierPathWithOvalInRect:imageFrame].CGPath;
    _circleShape.fillColor = _circleColor.CGColor;
    _circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0);
    [self.layer addSublayer: _circleShape];
    
    
    
    _circleMask  = [CAShapeLayer layer];
    _circleMask.bounds = imageFrame;
    _circleMask.position = imgCenterPoint;
    _circleMask.fillRule = kCAFillRuleEvenOdd;
    _circleShape.mask = _circleMask;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:imageFrame];
    [maskPath addArcWithCenter:imgCenterPoint radius:0.1 startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    
    _circleMask.path = maskPath.CGPath;
    
    
    //===============
    // line layer
    //===============
    for (int i = 0; i < 5; i ++) {
        CAShapeLayer * line = [CAShapeLayer layer];
        line.bounds = lineFrame;
        line.position = imgCenterPoint;
        line.masksToBounds = true;
        line.actions = @{@"strokeStart": [NSNull null], @"strokeEnd": [NSNull null]};
        line.strokeColor = _lineColor.CGColor;
        line.lineWidth = 1.25;
        line.miterLimit = 1.25;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, lineFrame.origin.x + lineFrame.size.width / 2, lineFrame.origin.y + lineFrame.size.height / 2);
        CGPathAddLineToPoint(path, nil, lineFrame.origin.x + lineFrame.size.width / 2, lineFrame.origin.y);
        line.path = path;
        line.lineCap = kCALineCapRound;
        line.lineJoin = kCALineJoinRound;
        line.strokeStart = 0.0;
        line.strokeEnd = 0.0;
        line.opacity = 0.0;
        line.transform = CATransform3DMakeRotation(M_PI / 5 * (i * 2.0 + 1), 0.0, 0.0, 1.0);
        [self.layer addSublayer:line];
        [_lines addObject:line];
    }
    
    
    //===============
    // image layer
    //===============
    _imageShape =  [CAShapeLayer layer];
    _imageShape.bounds = imageFrame;
    _imageShape.position = imgCenterPoint;
    _imageShape.path = [UIBezierPath bezierPathWithRect:imageFrame].CGPath;
    _imageShape.fillColor = _imageColorOff.CGColor;
    _imageShape.actions = @{@"fillColor": [NSNull null]};
    [self.layer addSublayer:_imageShape];
    
    
    CALayer * imageMask = [CALayer layer];
    imageMask.contents = (__bridge id)(image.CGImage);

 //   imageMask.contents = CFBridgingRelease(image.CGImage);
    imageMask.bounds = imageFrame;
    imageMask.position = imgCenterPoint;
    _imageShape.mask = imageMask;
    

    //==============================
    // circle transform animation
    //==============================
    self.circleTransform.duration = 0.333; // 0.0333 * 10
    self.circleTransform.values = @[
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,  0.0,  1.0)],    //  0/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.5,  0.5,  1.0)],    //  1/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.0,  1.0,  1.0)],    //  2/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,  1.2,  1.0)],    //  3/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.3,  1.3,  1.0)],    //  4/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.37, 1.37, 1.0)],    //  5/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0)],    //  6/10
                                    [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0)],    // 10/10
                                    ];
    self.circleTransform.keyTimes = @[
                                      [NSNumber numberWithFloat:0.0],    //  0/10
                                      [NSNumber numberWithFloat:0.1],    //  1/10
                                      [NSNumber numberWithFloat:0.2],    //  2/10
                                      [NSNumber numberWithFloat:0.3],    //  3/10
                                      [NSNumber numberWithFloat:0.4],    //  4/10
                                      [NSNumber numberWithFloat:0.5],    //  5/10
                                      [NSNumber numberWithFloat:0.6],    //  6/10
                                      [NSNumber numberWithFloat:1.0]     // 10/10
                                      ];
    
    self.circleMaskTransform.duration = 0.333; // 0.0333 * 10
    self.circleMaskTransform.values = @[
                                        [NSValue valueWithCATransform3D: CATransform3DIdentity],    //  0/10
                                        [NSValue valueWithCATransform3D: CATransform3DIdentity],    //  2/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 1.25,  imageFrame.size.height * 1.25,  1.0)],    //  3/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 2.688, imageFrame.size.height * 2.688, 1.0)],    //  4/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 3.923, imageFrame.size.height * 3.923, 1.0)],    //  5/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 4.375, imageFrame.size.height * 4.375, 1.0)],    //  6/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 4.731, imageFrame.size.height * 4.731, 1.0)],    //  7/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 5.0,   imageFrame.size.height * 5.0,   1.0)],    // 9/10
                                        [NSValue valueWithCATransform3D: CATransform3DMakeScale(imageFrame.size.width * 5.0,   imageFrame.size.height * 5.0,   1.0)],    // 10/10
                                        ];
    self.circleMaskTransform.keyTimes = @[
                                          [NSNumber numberWithFloat:0.0],    //  0/10
                                          [NSNumber numberWithFloat:0.2],    //  2/10
                                          [NSNumber numberWithFloat:0.3],    //  3/10
                                          [NSNumber numberWithFloat:0.4],    //  4/10
                                          [NSNumber numberWithFloat:0.5],    //  5/10
                                          [NSNumber numberWithFloat:0.6],    //  6/10
                                          [NSNumber numberWithFloat:0.7],    //  7/10
                                          [NSNumber numberWithFloat:0.9],    //  9/10
                                          [NSNumber numberWithFloat:1.0]     // 10/10
                                          ];
    
    //==============================
    // line stroke animation
    //==============================
    self.lineStrokeStart.duration = 0.6; //0.0333 * 18
    self.lineStrokeStart.values = @[
                                    [NSNumber numberWithFloat:0.0],    //  0/18
                                    [NSNumber numberWithFloat:0.0],    //  1/18
                                    [NSNumber numberWithFloat:0.18],   //  2/18
                                    [NSNumber numberWithFloat:0.2],    //  3/18
                                    [NSNumber numberWithFloat:0.26],   //  4/18
                                    [NSNumber numberWithFloat:0.32],   //  5/18
                                    [NSNumber numberWithFloat:0.4],    //  6/18
                                    [NSNumber numberWithFloat:0.6],    //  7/18
                                    [NSNumber numberWithFloat:0.71],   //  8/18
                                    [NSNumber numberWithFloat:0.89],   // 17/18
                                    [NSNumber numberWithFloat:0.92]    // 18/18
                                    ];
    self.lineStrokeStart.keyTimes = @[
                                      [NSNumber numberWithFloat:0.0],    //  0/18
                                      [NSNumber numberWithFloat:0.056],  //  1/18
                                      [NSNumber numberWithFloat:0.111],  //  2/18
                                      [NSNumber numberWithFloat:0.167],  //  3/18
                                      [NSNumber numberWithFloat:0.222],  //  4/18
                                      [NSNumber numberWithFloat:0.278],  //  5/18
                                      [NSNumber numberWithFloat:0.333],  //  6/18
                                      [NSNumber numberWithFloat:0.389],  //  7/18
                                      [NSNumber numberWithFloat:0.444],  //  8/18
                                      [NSNumber numberWithFloat:0.944],  // 17/18
                                      [NSNumber numberWithFloat:1.0],    // 18/18
                                      ];
    
    self.lineStrokeEnd.duration = 0.6; //0.0333 * 18
    self.lineStrokeEnd.values = @[
                                  [NSNumber numberWithFloat:0.0],    //  0/18
                                  [NSNumber numberWithFloat:0.0],    //  1/18
                                  [NSNumber numberWithFloat:0.32],   //  2/18
                                  [NSNumber numberWithFloat:0.48],   //  3/18
                                  [NSNumber numberWithFloat:0.64],   //  4/18
                                  [NSNumber numberWithFloat:0.68],   //  5/18
                                  [NSNumber numberWithFloat:0.92],   // 17/18
                                  [NSNumber numberWithFloat:0.92]    // 18/18
                                  ];
    self.lineStrokeEnd.keyTimes = @[
                                    [NSNumber numberWithFloat:0.0],    //  0/18
                                    [NSNumber numberWithFloat:0.056],  //  1/18
                                    [NSNumber numberWithFloat:0.111],  //  2/18
                                    [NSNumber numberWithFloat:0.167],  //  3/18
                                    [NSNumber numberWithFloat:0.222],  //  4/18
                                    [NSNumber numberWithFloat:0.278],  //  5/18
                                    [NSNumber numberWithFloat:0.944],  // 17/18
                                    [NSNumber numberWithFloat:1.0],    // 18/18
                                    ];
    
    self.lineOpacity.duration = 1.0; //0.0333 * 30
    self.lineOpacity.values = @[
                                [NSNumber numberWithFloat:1.0],    //  0/30
                                [NSNumber numberWithFloat:1.0],    // 12/30
                                [NSNumber numberWithFloat:0.0]     // 17/30
                                ];
    self.lineOpacity.keyTimes = @[
                                  [NSNumber numberWithFloat:0.0],    //  0/30
                                  [NSNumber numberWithFloat:0.40],    // 12/30
                                  [NSNumber numberWithFloat:0.567]   // 17/30
                                  ];
    
    //==============================
    // image transform animation
    //==============================
    self.imageTransform.duration = 1.0; //0.0333 * 30
    self.imageTransform.values = @[
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)],  //  0/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)],  //  3/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)],  //  9/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.25,  1.25,  1.0)],  // 10/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)],  // 11/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)],  // 14/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)],  // 15/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)],  // 16/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)],  // 17/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)],  // 20/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.025, 1.025, 1.0)],  // 21/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)],  // 22/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)],  // 25/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.95,  0.95,  1.0)],  // 26/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)],  // 27/30
                                   [NSValue valueWithCATransform3D: CATransform3DMakeScale(0.99,  0.99,  1.0)],  // 29/30
                                   [NSValue valueWithCATransform3D: CATransform3DIdentity]                       // 30/30
                                   ];
    self.imageTransform.keyTimes = @[
                                     [NSNumber numberWithFloat:0.0],    //  0/30
                                     [NSNumber numberWithFloat:0.1],    //  3/30
                                     [NSNumber numberWithFloat:0.3],    //  9/30
                                     [NSNumber numberWithFloat:0.333],  // 10/30
                                     [NSNumber numberWithFloat:0.367],  // 11/30
                                     [NSNumber numberWithFloat:0.467],  // 14/30
                                     [NSNumber numberWithFloat:0.5],    // 15/30
                                     [NSNumber numberWithFloat:0.533],  // 16/30
                                     [NSNumber numberWithFloat:0.567],  // 17/30
                                     [NSNumber numberWithFloat:0.667],  // 20/30
                                     [NSNumber numberWithFloat:0.7],    // 21/30
                                     [NSNumber numberWithFloat:0.733],  // 22/30
                                     [NSNumber numberWithFloat:0.833],  // 25/30
                                     [NSNumber numberWithFloat:0.867],  // 26/30
                                     [NSNumber numberWithFloat:0.9],    // 27/30
                                     [NSNumber numberWithFloat:0.967],  // 29/30
                                     [NSNumber numberWithFloat:1.0]     // 30/30
                                     ];
}

@end
