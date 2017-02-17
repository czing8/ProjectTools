//
//  VTextSwitch.m
//  VariousButtons
//
//  Created by Vols on 2015/11/21.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import "VTextSwitch.h"

#define kSwitchMaxHeight    80.0f
#define kSwitchMinHeight    20.0f
#define kSwitchMinWidth     40.0f

#define kSwitchBallSize     30.0f
#define kTimeInteval        0.1f

@interface VTextSwitch ()

@property (nonatomic, strong) UIView    * containerView;
@property (nonatomic, strong) UIView    * onContentView;
@property (nonatomic, strong) UIView    * offContentView;
@property (nonatomic, strong) UIColor   * onColor;
@property (nonatomic, assign) NSInteger ballSize;
@property (nonatomic, strong) UIFont    * font;
@property (nonatomic, strong) UIColor   * offColor;
@property (nonatomic, strong) UIView    * knobView;
@property (nonatomic, strong) UILabel   * onLabel;
@property (nonatomic, strong) UILabel   * offLabel;

- (CGRect)roundRect:(CGRect)frameOrBounds;

@end

@implementation VTextSwitch

+ (instancetype)switchWithFrame:(CGRect)frame onColor:(UIColor *)onColor offColor:(UIColor *)offColor font:(float)font ballSize:(NSInteger)ballSize {
    VTextSwitch * textSwitch = [[VTextSwitch alloc] initWithFrame:frame];

    textSwitch.ballSize = ballSize;
    textSwitch.font     = [UIFont systemFontOfSize:font];
    textSwitch.onColor  = onColor;
    textSwitch.offColor = offColor;

    return textSwitch;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[self roundRect:frame]];
    if (self) {
        self.ballSize   = kSwitchBallSize;
        self.font       = [UIFont systemFontOfSize:24];
        self.onColor    = kRGB(240, 0, 130);
        self.offColor   = kRGB(0, 192, 246);
        
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}


#pragma mark - setter 

- (void)setBounds:(CGRect)bounds {
    [super setBounds:[self roundRect:bounds]];
    
    [self setNeedsLayout];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:[self roundRect:frame]];
    
    [self setNeedsLayout];
}

- (void)setOnText:(NSString *)onText {
    if (_onText != onText) {
        _onText = onText;
        
        _onLabel.text = onText;
    }
}

- (void)setOffText:(NSString *)offText {
    if (_offText != offText) {
        _offText = offText;
        
        _offLabel.text = offText;
    }
}

- (void)setOnTintColor:(UIColor *)onTintColor {
    if (_onTintColor != onTintColor) {
        _onTintColor = onTintColor;
        
        _onContentView.backgroundColor = onTintColor;
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (_tintColor != tintColor) {
        _tintColor = tintColor;
        
        _offContentView.backgroundColor = tintColor;
    }
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    if (_thumbTintColor != thumbTintColor) {
        _thumbTintColor = thumbTintColor;
        
        _knobView.backgroundColor = _thumbTintColor;
    }
}

- (void)setFont:(UIFont *)font {
    if (_font != font) {
        _font = font;
    
        _onLabel.font = _font;
        _offLabel.font = _font;
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.containerView.frame = self.bounds;
    
    CGFloat r = CGRectGetHeight(self.containerView.bounds) / 2.0;
    
    self.containerView.layer.cornerRadius = r;
    self.containerView.layer.masksToBounds = YES;
    
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0;
    
    if (!self.isOn) {
        // frame of off status
        self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(margin,
                                         margin,
                                         self.ballSize,
                                         self.ballSize);
    } else {
        // frame of on status
        self.onContentView.frame = CGRectMake(0,
                                              0,
                                              CGRectGetWidth(self.containerView.bounds),
                                              CGRectGetHeight(self.containerView.bounds));
        
        self.offContentView.frame = CGRectMake(0,
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetWidth(self.containerView.bounds),
                                               CGRectGetHeight(self.containerView.bounds));
        
        self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - self.ballSize,
                                         margin,
                                         self.ballSize,
                                         self.ballSize);
    }
    
    CGFloat lHeight = 20.0f;
    CGFloat lMargin = r - (sqrtf(powf(r, 2) - powf(lHeight / 2.0, 2))) + margin;
    
    self.onLabel.frame = CGRectMake(lMargin,
                                    r - lHeight / 2.0,
                                    CGRectGetWidth(self.onContentView.bounds) - lMargin - self.ballSize - 2 * margin,
                                    lHeight);
    
    self.offLabel.frame = CGRectMake(self.ballSize + 2 * margin,
                                     r - lHeight / 2.0,
                                     CGRectGetWidth(self.onContentView.bounds) - lMargin - self.ballSize - 2 * margin,
                                     lHeight);
}

- (void)setOn:(BOOL)on {
    [self setOn:on animated:YES];
}

- (void)setOn:(BOOL)on animated:(BOOL)animated {
    if (_on == on)  return;
    
    _on = on;
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0;
    
    if (!animated) {
        if (!self.isOn) {
            self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds), 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            
            self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
        } else {
            self.onContentView.frame = CGRectMake(0,  0, CGRectGetWidth(self.containerView.bounds),  CGRectGetHeight(self.containerView.bounds));
            
            self.offContentView.frame = CGRectMake(0,  CGRectGetWidth(self.containerView.bounds), CGRectGetWidth(self.containerView.bounds),  CGRectGetHeight(self.containerView.bounds));
            
            self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - self.ballSize,  margin,  self.ballSize, self.ballSize);
        }
    } else {
        if (self.isOn) {
            [UIView animateWithDuration:kTimeInteval animations:^{
                
                self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - self.ballSize, margin, self.ballSize, self.ballSize);
                
            } completion:^(BOOL finished){
                
                self.onContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
                
                self.offContentView.frame = CGRectMake(0, CGRectGetWidth(self.containerView.bounds),   CGRectGetWidth(self.containerView.bounds),  CGRectGetHeight(self.containerView.bounds));
            }];
        } else {
            [UIView animateWithDuration:kTimeInteval animations:^{
                
                self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
                
            } completion:^(BOOL finished){
                
                self.onContentView.frame = CGRectMake(-1 * CGRectGetWidth(self.containerView.bounds),  0, CGRectGetWidth(self.containerView.bounds),  CGRectGetHeight(self.containerView.bounds));
                
                self.offContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), CGRectGetHeight(self.containerView.bounds));
            }];
        }
    }
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - Private API

- (void)initialization {
    self.backgroundColor = [UIColor clearColor];
    
    _onTintColor    = self.onColor;
    _tintColor      = self.offColor;
    _thumbTintColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    _textFont   = self.font;
    _textColor  = [UIColor whiteColor];
    
    [self addSubview:self.containerView];
    [_containerView addSubview:self.onContentView];
    [_containerView addSubview:self.offContentView];
    [_containerView addSubview:self.knobView];
    [_onContentView addSubview:self.onLabel];
    [_offContentView addSubview:self.offLabel];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [self addGestureRecognizer:panGesture];
}

- (CGRect)roundRect:(CGRect)frameOrBounds {
    CGRect newRect = frameOrBounds;
    
    if (newRect.size.height > kSwitchMaxHeight) {
        newRect.size.height = kSwitchMaxHeight;
    }
    
    if (newRect.size.height < kSwitchMinHeight) {
        newRect.size.height = kSwitchMinHeight;
    }
    
    if (newRect.size.width < kSwitchMinWidth) {
        newRect.size.width = kSwitchMinWidth;
    }
    
    return newRect;
}


#pragma mark - Properties

- (UIView *)containerView {
    if (_containerView == nil) {
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIView *)onContentView {
    if (_onContentView == nil) {
        _onContentView = [[UIView alloc] initWithFrame:self.bounds];
        _onContentView.backgroundColor = _onTintColor;
    }
    return _onContentView;
}

- (UIView *)offContentView {
    if (_offContentView == nil) {
        _offContentView = [[UIView alloc] initWithFrame:self.bounds];
        _offContentView.backgroundColor = _tintColor;
    }
    return _offContentView;
}

- (UIView *)knobView {
    if (_knobView == nil) {
        _knobView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.ballSize, self.ballSize)];
        _knobView.backgroundColor = _thumbTintColor;
        _knobView.layer.cornerRadius = self.ballSize / 2.0;
    }
    return _knobView;
}


- (UILabel *)onLabel {
    if (_onLabel == nil) {
        _onLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _onLabel.backgroundColor = [UIColor clearColor];
        _onLabel.textAlignment = NSTextAlignmentCenter;
        _onLabel.textColor = _textColor;
        _onLabel.font = _font;
        _onLabel.text = _onText;
    }
    return _onLabel;
}

- (UILabel *)offLabel {
    if (_offLabel == nil) {
        _offLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _offLabel.backgroundColor = [UIColor clearColor];
        _offLabel.textAlignment = NSTextAlignmentCenter;
        _offLabel.textColor = _textColor;
        _offLabel.font = _font;
        _offLabel.text = _offText;
    }
    return _offLabel;
}


#pragma mark - GestureRecognizer Actions

- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self setOn:!self.isOn animated:YES];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)recognizer {
    CGFloat margin = (CGRectGetHeight(self.bounds) - self.ballSize) / 2.0;
    CGFloat offset = 6.0f;
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            if (!self.isOn) {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.knobView.frame = CGRectMake(margin, margin, self.ballSize + offset, self.ballSize);
                }];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                    
                    self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - margin - (self.ballSize + offset), margin, self.ballSize + offset, self.ballSize);
                }];
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            if (!self.isOn) {
                [UIView animateWithDuration:0.25  animations:^{
                    
                    self.knobView.frame = CGRectMake(margin, margin, self.ballSize, self.ballSize);
                }];
            } else {
                [UIView animateWithDuration:0.25 animations:^{
                                     self.knobView.frame = CGRectMake(CGRectGetWidth(self.containerView.bounds) - self.ballSize, margin, self.ballSize, self.ballSize);
                }];
            }
            break;
        }
        case UIGestureRecognizerStateChanged:{
            break;
        }
        case UIGestureRecognizerStateEnded:
            [self setOn:!self.isOn animated:YES];
            break;
        case UIGestureRecognizerStatePossible:
            break;
    }
}



@end
