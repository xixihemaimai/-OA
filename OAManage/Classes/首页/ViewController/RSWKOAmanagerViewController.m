//
//  RSWKOAmanagerViewController.m
//  OAManage
//
//  Created by mac on 2018/11/27.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSWKOAmanagerViewController.h"

#import "RSViewProgressLine.h"
#import <WebKit/WebKit.h>

#import "RSApprovalProcessViewController.h"


@interface RSWKOAmanagerViewController ()<WKNavigationDelegate,UINavigationControllerDelegate,WKScriptMessageHandler>

@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;

@end

@implementation RSWKOAmanagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableview.hidden = YES;
    self.emptyView.hidden = YES;
    self.title = @"审批";
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    //CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    //CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
    self.htmlView = [[UIView alloc]init];
    //WithFrame:CGRectMake(0, navY + navHeight, [UIScreen mainScreen].bounds.size.width,SCH - (navY + navHeight))
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    //WithFrame:CGRectMake(0, 0, SCW, 1)
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLineview];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController * userContent = [[WKUserContentController alloc]init];
    
     [userContent addScriptMessageHandler:self name:@"jump"];
     [userContent addScriptMessageHandler:self name:@"reload"];
    
    config.userContentController = userContent;
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) configuration:config];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * stoneUrlStr =[NSString stringWithFormat:@"%@?billId=%ld&billKey=%@&aesKey=%@&appLoginToken=%@&workItemId=%ld&username=%@&userdepartment=%@&usertime=%@&type=0",@"http://192.168.1.48:8089/Yigo1.6/Approval.html",(long)self.billId,self.billKey,aes,self.usermodel.appLoginToken,(long)self.workItemId,self.usermodel.userName,self.usermodel.deptName,self.usertime];
    
    NSLog(@"================%@",stoneUrlStr);
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        
        stoneUrlStr = [stoneUrlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        stoneUrlStr= [stoneUrlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSURL * urlStr = [[NSURL alloc]initWithString:stoneUrlStr];
    //    NSString * body = [NSString stringWithFormat:@"pageType=%ld appType = %ld userId = %@ mtlCode = %@ totalSheetSun = %ld totalVol = %ld selectedkeyArr = %@ mtlName = %@ blockno = %@ turnsno = %ld datefrom = %@ dateto = %@ whsname = %@ storeareaname = %@ locationname = %@ ",self.pageType,self.appType,self.usermodel.userID,self.mtlCode,self.totalSheetSun,self.totalVol,self.selectedkeyArr,self.mtlName,self.blockno,self.turnsno,self.datefrom,self.dateto,self.whsname,self.storeareaname,self.locationname];
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:urlStr];
    // [requst setHTTPMethod:@"POST"];
    // [requst setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
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

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"jump"]) {
       NSString * shareStr = message.body;
        [self jumpPageIndex:[shareStr integerValue]
         ];
    }else if ([message.name isEqualToString:@"reload"]){
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",message.body]];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reLoadCurrentViewData" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)jumpPageIndex:(NSInteger)billId{
    RSApprovalProcessViewController * approvalProcessVc = [[RSApprovalProcessViewController alloc]init];
    approvalProcessVc.billId = billId;
    [self.navigationController pushViewController:approvalProcessVc animated:YES];
    
}






- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"tixing"];
}




- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"是否允许这个导航");
    decisionHandler(WKNavigationActionPolicyAllow);
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //    Decides whether to allow or cancel a navigation after its response is known.
    
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    decisionHandler(WKNavigationResponsePolicyAllow);
}




//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview startLoadingAnimation];
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"跳转到其他的服务器");
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页开始接收网页内容");
}


//网页导航加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

//网页由于某些原因加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败,失败原因:%@",[error description]);
    
}


- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"网页加载内容进程终止");
}



@end
