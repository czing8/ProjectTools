//
//  VSwitch.h
//  VariousButtons
//
//  Created by Vols on 2015/11/21.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSwitchFaceLayer;

typedef void(^SwitchDidSelectedBlock)(BOOL isOn);

@interface VSwitch : UIView


@property (nonatomic,strong) UIColor * onColor;
@property (nonatomic,strong) UIColor * offColor;

@property (nonatomic,strong) UIColor * headColor;

@property (nonatomic,assign) BOOL isOn;

@property (nonatomic,strong) VSwitchFaceLayer *  faceLayer;

/**
 *  block will call when u select switch and animation stop
 */
-(void)setSwitchDidSelectedBlock:(SwitchDidSelectedBlock)block;

@end
