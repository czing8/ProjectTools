//
//  V2WebViewController.m
//  ProjectTools
//
//  Created by Vols on 2016/12/9.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "V2WebViewController.h"
//#import <WebKit/WebKit.h>
//#import <WebKit/WKWebView.h>
//
//@interface V2WebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate>
//
//@property (nonatomic, strong) WKWebView         * webView;
//@property (nonatomic, strong) UIProgressView    * progressView;
//
//@end

@implementation V2WebViewController

-(void)dealloc{
//    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}


- (void)viewDidLoad {
    [super viewDidLoad];

}

//#pragma mark - Properties
//
//- (WKWebView *)wkWebView {
//    if (_webView == nil) {
//        
//        WKWebViewConfiguration * conf = [[WKWebViewConfiguration alloc]init];
//        conf.allowsAirPlayForMediaPlayback = YES;   //允许视频播放
//        conf.allowsInlineMediaPlayback = YES;       // 允许在线播放
//        conf.selectionGranularity = YES;            // 允许可以与网页交互，选择视图
//        conf.processPool = [[WKProcessPool alloc] init];   // web内容处理池
//        
//        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
//        WKUserContentController * userContentController = [[WKUserContentController alloc]init];
//        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
//        [userContentController addScriptMessageHandler:self name:@"WXPay"];
//        conf.suppressesIncrementalRendering = YES;   // 是否支持记忆读取
//        conf.userContentController = userContentController; // 允许用户更改网页的设置
//        
//        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:conf];
//        _webView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
//        _webView.navigationDelegate = self;
//        _webView.UIDelegate = self;
//        
//        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
//        _webView.allowsBackForwardNavigationGestures = YES;        // 开启手势触摸
//        [_webView sizeToFit];             //适应你设定的尺寸
//    }
//    return _webView;
//}
//
//- (UIProgressView *)progressView {
//    if (_progressView == nil) {
//        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
//        _progressView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 2);
//        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
//        _progressView.progressTintColor = [UIColor greenColor];
//    }
//    return _progressView;
//}
//
//#pragma mark - WKNavigationDelegate
//
//// 开始加载
//-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    self.progressView.hidden = NO;
//}
//
////内容返回时调用
//-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
//    
//}
//
////这个是网页加载完成，导航的变化
//-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
//    /*
//     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），否则不显示，或则部分显示时这个方法就不调用。
//     */
//    self.title = self.wkWebView.title;
//    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//}
//
//
////服务器请求跳转的时候调用
//-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
//    
//}
//
////服务器开始请求的时候调用
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//// 内容加载失败时候调用
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
//    NSLog(@"页面加载超时");
//}
//
////跳转失败的时候调用
//- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//}
//
////进度条
//- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
//    
//}
//
//#pragma mark - WKUIDelegate
//// 获取js 里面的提示
//- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:NULL];
//}
//
//// js 信息的交流
//- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//    }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//    }]];
//    [self presentViewController:alert animated:YES completion:NULL];
//}
//
//// 交互。可输入的文本。
//- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//        textField.textColor = [UIColor redColor];
//    }];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler([[alert.textFields lastObject] text]);
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:NULL];
//}
//
//
////KVO监听进度条
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    
//    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
//        [self.progressView setAlpha:1.0f];
//        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
//        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
//        
//        // Once complete, fade out UIProgressView
//        if(self.wkWebView.estimatedProgress >= 1.0f) {
//            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
//                [self.progressView setAlpha:0.0f];
//            } completion:^(BOOL finished) {
//                [self.progressView setProgress:0.0f animated:NO];
//            }];
//        }
//    }
//    else {
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//
//
////拦截执行网页中的JS方法
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
//    
//    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
//    //客户端写法 message.name isEqualToString:@"名字"]
//    if ([message.name isEqualToString:@"WXPay"]) {
//        NSLog(@"%@", message.body);
//        //调用微信支付方法
//        //        [self WXPayWithParam:message.body];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
