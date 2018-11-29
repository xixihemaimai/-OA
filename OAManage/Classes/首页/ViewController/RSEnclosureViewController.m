//
//  RSEnclosureViewController.m
//  OAManage
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSEnclosureViewController.h"
#import <WebKit/WebKit.h>
@interface RSEnclosureViewController ()<WKNavigationDelegate,UINavigationControllerDelegate,WKScriptMessageHandler>
@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;

@end

@implementation RSEnclosureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableview.hidden = YES;
    self.emptyView.hidden = YES;
    self.title = @"审批";
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.htmlView = [[UIView alloc]init];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLineview];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController * userContent = [[WKUserContentController alloc]init];
    config.userContentController = userContent;
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) configuration:config];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    
    
    
    
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
//        stoneUrlStr = [stoneUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//        [NSCharacterSet URLQueryAllowedCharacterSet];
//    }else{
//        stoneUrlStr= [stoneUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
    //NSURL * urlStr = [[NSURL alloc]initWithString:stoneUrlStr];
    
    
    NSString * urlTempStr = self.urlStr;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        urlTempStr = [urlTempStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        urlTempStr = [urlTempStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURL * urlStr = [NSURL fileURLWithPath:urlTempStr];
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:urlStr];
    [_webView loadRequest:requst];
    [self.htmlView addSubview:webview];
    self.htmlView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .topSpaceToView(self.navigationController.navigationBar, 0);
    self.progressLineview.sd_layout
    .leftSpaceToView(self.htmlView, 0)
    .rightSpaceToView(self.htmlView, 0)
    .topSpaceToView(self.htmlView, 0)
    .heightIs(2);
    self.webView.sd_layout
    .leftSpaceToView(self.htmlView, 0)
    .rightSpaceToView(self.htmlView, 0)
    .topSpaceToView(self.progressLineview, 0)
    .bottomSpaceToView(self.htmlView, 0);
    
}


//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview startLoadingAnimation];
}


//网页导航加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

//网页由于某些原因加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
