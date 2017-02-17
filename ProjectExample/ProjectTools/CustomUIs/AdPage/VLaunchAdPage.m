//
//  VLaunchAdPage.m
//  AdPage
//
//  Created by Vols on 2017/1/20.
//  Copyright © 2017年 vols. All rights reserved.
//

#import "VLaunchAdPage.h"
#import "Masonry.h"

#define kDefaultDuration     20  // 默认停留时间

#define kCurWindow  [[UIApplication sharedApplication].windows firstObject]

#define keyWindow  [UIApplication sharedApplication].keyWindow

@interface VLaunchAdPage ()

@property (nonatomic, strong) UIImageView   *adImgView;
@property (nonatomic, strong) UIButton      *skipButton;

@property (nonatomic, copy  ) dispatch_source_t timer;
@property (nonatomic, assign) NSInteger     adDuration;
@property (nonatomic, strong) NSString      *adImageURLString;  
@property (nonatomic, strong) UIImage       *adImage;

@end


@implementation VLaunchAdPage

#pragma mark - LifeCycle

+ (instancetype)launchAdPage {
    VLaunchAdPage *launchAd = [[VLaunchAdPage alloc] init];
    return launchAd;
}

// 本地图片
+ (instancetype)launchPageWithImage:(UIImage *)adImage {
    return [self launchPageWithImage:adImage duration:kDefaultDuration];
}

+ (instancetype)launchPageWithImage:(UIImage *)adImage duration:(NSInteger)duration{
    VLaunchAdPage *launchAd = [[VLaunchAdPage alloc] init];
    launchAd.adDuration = duration;
    launchAd.adImgView.image = adImage;
    return launchAd;
}

// 网络图片
+ (instancetype)launchPageWithImageURL:(NSString *)imageURL {
    return [VLaunchAdPage launchPageWithImageURL:imageURL duration:kDefaultDuration];
}

+ (instancetype)launchPageWithImageURL:(NSString *)imageURL duration:(NSInteger)duration{
    VLaunchAdPage *launchAd = [[VLaunchAdPage alloc] init];
    launchAd.adDuration = duration;
    launchAd.adImageURLString = imageURL;
    return launchAd;
}


- (instancetype)init {
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        _adDuration = kDefaultDuration;
        _popAnimationType = LaunchAnimationTypeNone;
        
        self.image = [self getLaunchImage];  // 获取系统启动图，在广告图显示前占位

        [self addSubview:self.adImgView];
        [self addSubview:self.skipButton];
        
        [_adImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.right.equalTo(@-20);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
    }
    return self;
}


#pragma mark - Public

- (void)showInView:(UIView *)superView animationType:(LaunchAnimationType)animationType clickHandler:(LaunchNoParmaBlock)clickHandler {
    
    if (superView == nil) {
        NSLog(@"superView can't nil");
        return;
    }
    self.clickHandler = clickHandler;
    superView.hidden = NO;
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.popAnimationType = animationType;
    
    [self downloadAdImage:_adImageURLString complete:^(UIImage *adImage) {
        self.adImage = adImage;
        self.adImgView.image = adImage;
        [self showAnimation];
    }];
    
/*
    // 如果需要先一步获取图片URL，可以把请求加载这里
    [LaunchRequest getLaunchPageImageResult:^(NSString *imageURLString, NSInteger second) {
        
        if (imageURLString == nil) {
            if (self.dismissHandle)     
                self.dismissHandle();
 
            return ;
        }
        
        self.imageURLString = imageURLString;
        self.adDuration = second;
        
        [self downloadAdImage:imageURLString complete:^(UIImage *adImage) {
            self.adImage = adImage;
            self.adImgView.image = adImage;
            [self showAnimation];
        }];
    }];
 */
}

- (void)showInWindowWithAnimationType:(LaunchAnimationType)animationType clickHandler:(LaunchNoParmaBlock)clickHandler {
    [self showInView:kCurWindow animationType:animationType clickHandler:clickHandler];
}

#pragma mark -

- (void)setHideSkip:(BOOL)hideSkip {
    _hideSkip = hideSkip;
    _skipButton.hidden = hideSkip;
}

#pragma mark - Actions

- (void)tapAction:(UITapGestureRecognizer *)tap {
    if(self.clickHandler){
        self.clickHandler();
    }
}

#pragma mark - Animaiton

- (void)showAnimation {
    self.skipButton.hidden = NO;
    [self dispath_timer];
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.adImgView.alpha = 1;
    } completion:nil];
}

- (void)dismissAnimation {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
    if (self.popAnimationType == LaunchAnimationTypeNone) {
        [self removeFromSuperview];
    }
    else if (self.popAnimationType == LaunchAnimationTypeFadeZoomOut) {
        CGAffineTransform transform_result = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.3 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            self.transform = transform_result;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    else if (self.popAnimationType == LaunchAnimationTypeFadeZoomIn) {
        CGAffineTransform transform_result = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView animateWithDuration:0.3 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            self.transform = transform_result;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
    
    self.hideSkip = YES;
    
    if (self.dismissHandler) {
        self.dismissHandler();
    }
}

- (void)dispath_timer {
    
    NSTimeInterval period = 1.0;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    
    __block NSInteger duration = _adDuration;
    
    dispatch_source_set_event_handler(_timer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(duration > 0)    duration--;
            if(duration <= 0)  [self dismissAnimation];
            
            [_skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过",(long)duration] forState:UIControlStateNormal];
        });
    });
    
    dispatch_resume(_timer);
}


#pragma mark - Properties

- (UIImageView *)adImgView {
    
    if(_adImgView == nil){
        _adImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _adImgView.backgroundColor = [UIColor clearColor];
        _adImgView.userInteractionEnabled = YES;
        _adImgView.alpha = 0.8;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_adImgView addGestureRecognizer:tap];
    }
    return _adImgView;
}


- (UIButton *)skipButton {
    
    if(_skipButton == nil){
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _skipButton.layer.cornerRadius = 15;
        _skipButton.layer.masksToBounds = YES;
        _skipButton.hidden = YES;
        [_skipButton setTitle:[NSString stringWithFormat:@"%ld 跳过",(long)_adDuration] forState:UIControlStateNormal];
        _skipButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_skipButton addTarget:self action:@selector(dismissAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //    if(_timer){
    //        dispatch_source_cancel(_timer);
    //        _timer = nil;
    //    }
}


#pragma mark - helper
// 获取系统启动图，精髓
- (UIImage *)getLaunchImage {
    NSString *viewOrientation = @"Portrait";
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        viewOrientation = @"Landscape";
    }
    
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    CGSize viewSize = kCurWindow.bounds.size;
    NSInteger viewSizeMaxValue = MAX(viewSize.width, viewSize.height);
    
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        //        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
        //            launchImageName = dict[@"UILaunchImageName"];
        //        }
        
        NSInteger imageSizeMaxValue = MAX(imageSize.width, imageSize.height);
        if (imageSizeMaxValue == viewSizeMaxValue && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    NSLog(@"launchImageName --> %@", launchImageName);
    return [UIImage imageNamed:launchImageName];
}


- (void)downloadAdImage:(NSString *)imageURLString complete:(void(^)(UIImage *adImage))complete{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (imageURLString == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(nil);
            });
            return ;
        }
        
        NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (imageData == nil) {
                complete(nil);
            }
            else {
                UIImage * adImage = [UIImage imageWithData:imageData];
                complete(adImage);
            }
        });
    });
}


@end
