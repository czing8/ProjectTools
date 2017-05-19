//
//  VFlatSwitch.h
//  VariousButtons
//
//  Created by Vols on 2015/11/21.
//  Copyright © 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VFlatSwitch : UIControl


@property (nonatomic, assign) BOOL on;

@property (nonatomic, strong) UIColor * inactiveColor;
@property (nonatomic, strong) UIColor * activeColor;

@property (nonatomic, strong) UIColor * onTintColor;
@property (nonatomic, strong) UIColor * onColor __deprecated;

/*
 *	Sets the border color that shows when the switch is off. Defaults to light gray.
 */
@property (nonatomic, strong) UIColor * borderColor;

/*
 *	Sets the knob color. Defaults to white.
 */
@property (nonatomic, strong) UIColor *thumbTintColor;
@property (nonatomic, strong) UIColor *knobColor __deprecated;


/*
 *	Sets the shadow color of the knob. Defaults to gray.
 */
@property (nonatomic, strong) UIColor *shadowColor;


/*
 *	Sets whether or not the switch edges are rounded.
 *  Set to NO to get a stylish square switch.
 *  Defaults to YES.
 */
@property (nonatomic, assign) BOOL isRounded;


/*
 *	Sets the image that shows when the switch is on.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
@property (nonatomic, strong) UIImage *onImage;

/*
 *	Sets the image that shows when the switch is off.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
@property (nonatomic, strong) UIImage *offImage;


/*
 * Set whether the switch is on or off. Optionally animate the change
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;


- (BOOL)isOn;


@end
