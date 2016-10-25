//
//  VImageView.m
//  Demo
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "VImageView.h"

@implementation VImageView

- (void) singleClickTarget:(id)target action:(SEL)selector {
    self.userInteractionEnabled = YES;
    _target = target;
    _selector = selector;
}

- (void) doubleClickTarget:(id)target action:(SEL)selector {
    self.userInteractionEnabled = YES;
    _dtarget = target;
    _dselector = selector;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    if (t.tapCount >= 2) {
        [_dtarget performSelector:_dselector withObject:self];
    } else if (t.tapCount == 1) {
        [_target performSelector:_selector withObject:self];
    }
}

@end
