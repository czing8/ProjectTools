//
//  NewsModel.m
//  HBDemo
//
//  Created by Vols on 2016/10/20.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "ReportModel.h"

#define kHandleParam(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;

@implementation ReportModel


//
//@property (nonatomic, strong) NSString *  shareurl;
//@property (nonatomic, strong) NSString *  shareimg;
//@property (nonatomic, strong) NSString *  sharetitle;
//@property (nonatomic, strong) NSString *  sharecontent;
//@property (nonatomic, strong) NSString *  isshowsharedialog;
//@property (nonatomic, strong) NSString *  isshowcomment;


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _DocName    = kHandleParam(@"DocName", @"");
        _DocTitle   = kHandleParam(@"DocTitle", @"");
        _DocUploadTime = kHandleParam(@"DocUploadTime", @"");
        _did    = kHandleParam(@"did", @"");
        _keys   = kHandleParam(@"keys", @"");
        _PageName = kHandleParam(@"PageName", @"");
        _lx = kHandleParam(@"lx", @"");
        
        if (dictionary[@"DocPages"] != nil && dictionary[@"DocPages"]!=[NSNull null]) {
            _DocPages = [dictionary[@"DocPages"] intValue];
        }
        
        
        _favoritetypeid  = kHandleParam(@"favoritetypeid", @"");
        _title  = kHandleParam(@"title", @"");
        _time   = kHandleParam(@"time", @"");
        _author = kHandleParam(@"author", @"");
        _filetype   = kHandleParam(@"filetype", @"");
        _publish    = kHandleParam(@"publish", @"");
        _typetitle  = kHandleParam(@"typetitle", @"");
        _filesize   = kHandleParam(@"filesize", @"");
        _filepages  = kHandleParam(@"filepages", @"");
        _filepages  = [NSString stringWithFormat:@"%@ 页",_filepages];
        _fileurl    = kHandleParam(@"fileurl", @"");
        _PublishPower   = kHandleParam(@"PublishPower", @"");
        _summary    = kHandleParam(@"summary", @"");
        _uploaduser = kHandleParam(@"uploaduser", @"");
        
        int filesize_kb = [_filesize intValue]/1024;
        _filesize = [NSString stringWithFormat:@"%d", filesize_kb];
    }
    return self;
}

@end
