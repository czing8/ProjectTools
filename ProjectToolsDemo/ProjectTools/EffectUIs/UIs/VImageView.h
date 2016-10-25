//
//  VImageView.h
//  Demo
//
//  Created by Vols on 16/3/11.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *      [imageView addSingleClickTarget:self action:@selector(imageViewClick:)];
 */
@interface VImageView : UIImageView
{
    id _target;
    SEL _selector;
    
    id _dtarget;
    SEL _dselector;
    
}

- (void) singleClickTarget:(id)target action:(SEL)selector;
- (void) doubleClickTarget:(id)target action:(SEL)selector;


@end
