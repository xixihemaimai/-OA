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

#import <QuickLook/QuickLook.h>

@interface RSWKOAmanagerViewController ()<WKNavigationDelegate,UINavigationControllerDelegate,WKScriptMessageHandler,QLPreviewControllerDelegate,QLPreviewControllerDataSource>

@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;

@property (nonatomic, copy)NSURL *fileURL; //文件路径


@property (nonatomic,strong) WKUserContentController * userContent;

@end

@implementation RSWKOAmanagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableview.hidden = YES;
    self.emptyView.hidden = YES;
    self.title = @"审批";
    

    //self.navigationController.navigationItem.leftBarButtonItem.enabled = NO;
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.htmlView = [[UIView alloc]init];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLineview];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController * userContent = [[WKUserContentController alloc]init];
    self.userContent = userContent;
     [userContent addScriptMessageHandler:self name:@"jump"];
     [userContent addScriptMessageHandler:self name:@"reload"];
     [userContent addScriptMessageHandler:self name:@"Submission"];
     [userContent addScriptMessageHandler:self name:@"Enclosure"];
    
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

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"jump"]) {
       NSString * shareStr = message.body;
        [self jumpPageIndex:[shareStr integerValue]
         ];
    }else if ([message.name isEqualToString:@"reload"]){
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",message.body]];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reLoadCurrentViewData" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([message.name isEqualToString:@"Submission"]){
        self.navigationItem.leftBarButtonItem.enabled = NO;
    }else if ([message.name isEqualToString:@"Enclosure"]){
        [self jumpEnclosureTempStr:message.body];
    }
}



//判断文件是否已经在沙盒中存在
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}




- (void)jumpEnclosureTempStr:(NSString *)tempStr{
    QLPreviewController *previewController =[[QLPreviewController alloc]init];
    previewController.delegate=self;
    previewController.dataSource=self;
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlStr = tempStr;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    NSString *fileName = [urlStr lastPathComponent]; //获取文件名称
    NSURL * URL = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //        判断是否存在
    if([self isFileExist:fileName]) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        self.fileURL = url;
        [self presentViewController:previewController animated:YES completion:nil];
        //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
        [previewController refreshCurrentPreviewItem];
    }else {
        //[SVProgressHUD showWithStatus:@"下载中"];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            [SVProgressHUD dismiss];
            self.fileURL = filePath;
            [self presentViewController:previewController animated:YES completion:nil];
            //                //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
            [previewController refreshCurrentPreviewItem];
        }];
        [downloadTask resume];
    }
}





-(NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

//QuickLook代理
-(id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return self.fileURL;
}


- (void)previewControllerWillDismiss:(QLPreviewController *)controller{
    [self.userContent addScriptMessageHandler:self name:@"Enclosure"];
}


- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
    NSLog(@"=================");
}


- (void)jumpPageIndex:(NSInteger)billId{
    RSApprovalProcessViewController * approvalProcessVc = [[RSApprovalProcessViewController alloc]init];
    approvalProcessVc.billId = billId;
    [self.navigationController pushViewController:approvalProcessVc animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"tixing"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"reload"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"Submission"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"Enclosure"];
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




@end
