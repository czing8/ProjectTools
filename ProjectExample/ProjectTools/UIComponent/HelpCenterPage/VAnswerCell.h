//
//  VAnswerCell.h
//  ProjectTools
//
//  Created by Vols on 2016/2/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "VHelpModel.h"

#define kAnswerCellIdentifier @"kAnswerCellIdentifier"

@interface VAnswerCell : UITableViewCell

@property (nonatomic, strong) VHelpModel   * model;

@end
