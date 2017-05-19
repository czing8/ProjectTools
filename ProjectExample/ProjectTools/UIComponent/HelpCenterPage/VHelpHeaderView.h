//
//  VHelpHeaderView.h
//  ProjectTools
//
//  Created by Vols on 2016/2/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VHelpModel.h"

#define SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)

typedef void (^VHelpHeaderNoParamBlock)();

@interface VHelpHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) VHelpModel                *helpModel;
@property (nonatomic,   copy) VHelpHeaderNoParamBlock   clickHandler;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
