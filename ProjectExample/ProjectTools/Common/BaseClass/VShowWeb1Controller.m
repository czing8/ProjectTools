//
//  VShowWeb1Controller.m
//  PrejectTools
//
//  Created by Vols on 2016/10/25.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "VShowWeb1Controller.h"

@interface VShowWeb1Controller () <UIWebViewDelegate>

@property (nonatomic, strong) UIButton  * backButton;
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIActivityIndicatorView * indicatorView;

@end

@implementation VShowWeb1Controller

- (void)dealloc {
    NSLog(@"%@ ---> release释放成功", NSStringFromClass([self class]));
}

- (instancetype)init {
    if (self = [super init]) {
        _backButtonHidden = YES;    // 默认
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureViews];
    
    NSLog(@"title --> %@, url --> %@", _theTitle, _theURL);
}

- (void)configureViews {
    self.view.backgroundColor = [UIColor whiteColor];

    self.titleLabel.text = _theTitle;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];

    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.indicatorView];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_theURL]];
    
    [_webView loadRequest:request];
}


- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebViewDelgate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicatorView startAnimating] ;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicatorView stopAnimating];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Properties

- (UIButton *)backButton {
    if (_backButton == nil) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 0, 44, 44);
        [_backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setTitle:@"X" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_SIZE.width, kSCREEN_SIZE.height - 64)];
        _webView.scalesPageToFit = YES;  //自动对页面进行缩放以适应屏幕
        _webView.delegate = self;
    }
    return _webView;
}

- (UIActivityIndicatorView *)indicatorView{
    if (_indicatorView == nil) {
        
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.center = CGPointMake([[UIScreen mainScreen]bounds].size.width/2, [[UIScreen mainScreen]bounds].size.height/2-44-20);
    }
    return _indicatorView;
}

@end
