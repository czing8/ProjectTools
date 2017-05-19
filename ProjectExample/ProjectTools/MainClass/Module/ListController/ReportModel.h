//
//  NewsModel.h
//  HBDemo
//
//  Created by Vols on 2016/10/20.
//  Copyright © 2016年 Vols. All rights reserved.
//  研报Model

#import <Foundation/Foundation.h>

@interface ReportModel : NSObject

@property (nonatomic, strong) NSString *  DocName;
@property (nonatomic, assign) int  DocPages;
@property (nonatomic, strong) NSString *  DocTitle;
@property (nonatomic, strong) NSString *  DocUploadTime;
@property (nonatomic, strong) NSString *  PageName;         //类型
@property (nonatomic, strong) NSString *  did;
@property (nonatomic, strong) NSString *  keys;             // 发布者
@property (nonatomic, strong) NSString *  lx;

@property (nonatomic, strong) NSString *  stockCode;

//研报详细页 使用
@property (nonatomic, strong) NSString *  favoritetypeid;
@property (nonatomic, strong) NSString *  title;
@property (nonatomic, strong) NSString *  time;
@property (nonatomic, strong) NSString *  filetype;
@property (nonatomic, strong) NSString *  author;
@property (nonatomic, strong) NSString *  publish;
@property (nonatomic, strong) NSString *  typetitle;
@property (nonatomic, strong) NSString *  filesize;
@property (nonatomic, strong) NSString *  filepages;
@property (nonatomic, strong) NSString *  fileurl;
@property (nonatomic, strong) NSString *  PublishPower;
@property (nonatomic, strong) NSString *  summary;
@property (nonatomic, strong) NSString *  uploaduser;

//@property (nonatomic, strong) NSString *  shareurl;
//@property (nonatomic, strong) NSString *  shareimg;
//@property (nonatomic, strong) NSString *  sharetitle;
//@property (nonatomic, strong) NSString *  sharecontent;
//@property (nonatomic, strong) NSString *  isshowsharedialog;
//@property (nonatomic, strong) NSString *  isshowcomment;


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
