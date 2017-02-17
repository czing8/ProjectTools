//
//  VEmptyViewHelper.h
//  ProjectTools
//
//  Created by Vols on 2015/2/13.
//  Copyright © 2015年 Vols. All rights reserved.
//

/*******************************************
 *  占位视图 模块
 *
 *  #breif 空白页，占位视图
 ******************************************/

#import <Foundation/Foundation.h>

@interface VEmptyViewHelper : NSObject

- (void)attachToView:(UIView *)attachView clickHandler:(void(^)())clickHandler;

/**
 *  移除占位视图
 */
- (void)hidePlaceholder;


/**
 *  判断tableView是否存在的方法
 */
- (BOOL)isHistoryListExits;

@end
