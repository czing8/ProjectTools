//
//  VerifyCodeButton.m
//  ProjectControls
//
//  Created by Vols on 2016/11/21.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "VerifyCodeButton.h"

#define kMaxSeconds 10       //设置倒计时时间

typedef void(^ClickHandler)(VerifyCodeButton* btn);

@interface VerifyCodeButton() {
    NSInteger   _times;
    NSTimer     * _timer;
}

@property (nonatomic, copy) ClickHandler clickHandler;

@end

@implementation VerifyCodeButton

+ (instancetype)buttonWithFrame:(CGRect)rect clickHandler:(void(^)(VerifyCodeButton* btn))clickHandler {
    VerifyCodeButton * codeBtn = [[VerifyCodeButton alloc] initWithFrame:rect];
    codeBtn.clickHandler = clickHandler;
    return codeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUIs];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUIs];
    }
    return self;
}

- (void)stopTimer {
    [self initStatus];
}

- (void)setupUIs {
    //默认设置
    self.backgroundColor    = [UIColor orangeColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor yellowColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setBackgroundImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(clickSelfBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self initStatus];
}

- (void)initStatus {

    self.userInteractionEnabled = YES;
    self.selected = NO;
    _times = kMaxSeconds;

    [_timer invalidate];
    _timer = nil;
}


- (void)clickSelfBtn:(VerifyCodeButton*)btn {
    if (self.userInteractionEnabled == NO) {
        return;
    }
    
    [self startTimer];
    _clickHandler(self);
}

- (void)startTimer {
    self.userInteractionEnabled = NO;
    self.selected = YES;
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(showLastTime) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantPast];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}


- (void)showLastTime {
    if (_times < 0) {
        [self initStatus];
        return;
    }
    
    NSString* str = [NSString stringWithFormat:@"%ld s",_times];
    [self setTitle:str forState:UIControlStateSelected];
    
    _times--;
}

- (void)didMoveToSuperview {
//    [self startTimer];
}



@end
