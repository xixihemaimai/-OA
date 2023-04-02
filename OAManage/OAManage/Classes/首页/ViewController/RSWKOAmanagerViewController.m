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
#import "AppDelegate.h"
#import "RSLoginViewController.h"
#import "QLPreviewItemCustom.h"

@interface RSWKOAmanagerViewController ()<WKNavigationDelegate,UINavigationControllerDelegate,WKScriptMessageHandler,QLPreviewControllerDelegate,QLPreviewControllerDataSource,TZImagePickerControllerDelegate,UIDocumentPickerDelegate>

@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;

@property (nonatomic, copy)NSURL *fileURL; //文件路径

@property (nonatomic,strong) WKUserContentController * userContent;


@property (nonatomic,strong)NSString * fileNewName;

@end

@implementation RSWKOAmanagerViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]intValue ] >= 9.0) {
        NSArray * types = @[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
        NSSet * websiteDataTypes = [NSSet setWithArray:types];
        NSDate * dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }else{
        NSString * libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString * cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
//        NSLog(@"%@", cookiesFolderPath);
        NSError * errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    self.tableview.hidden = YES;
    self.emptyView.hidden = YES;
    if ([self.type isEqualToString:@"0"]) {
        self.title = self.Currenttitle;
    }else if ([self.type isEqualToString:@"2"]){
    }else if ([self.type isEqualToString:@"5"]){
        self.title = @"隐私政策";
    }else if ([self.type isEqualToString:@"6"]){
        self.title = @"用户协议";
    }
    else{
        //self.title = @"审批";
    }
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.htmlView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCW, SCH - CGRectGetMaxY(self.navigationController.navigationBar.frame))];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    [self.htmlView addSubview:self.progressLineview];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController * userContent = [[WKUserContentController alloc]init];
    self.userContent = userContent;
    [userContent addScriptMessageHandler:self name:@"jump"];
    [userContent addScriptMessageHandler:self name:@"reload"];
    [userContent addScriptMessageHandler:self name:@"Submission"];
    [userContent addScriptMessageHandler:self name:@"Enclosure"];
    [userContent addScriptMessageHandler:self name:@"annexImgClick"];
    [userContent addScriptMessageHandler:self name:@"annexFileClick"];
    
    config.userContentController = userContent;
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) configuration:config];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * stoneUrlStr = @"";
    if ([self.type isEqualToString:@"0"]) {
        stoneUrlStr =[NSString stringWithFormat:@"%@",self.URL];
    }else if ([self.type isEqualToString:@"2"]){
        stoneUrlStr = [NSString stringWithFormat:@"%@?billKey=%@&jiamikey=%@&appLoginToken=%@&type=0&billId=%ld&isaddProcess=%@&deptName=%@&empName=%@&deptId=%ld&empId=%ld",URL_H5FQ_IOS,self.billKey,aes,self.usermodel.appLoginToken,self.billId,self.isaddProcess,self.usermodel.deptName,self.usermodel.empName,self.usermodel.deptId,self.usermodel.empId];
    }else if ([self.type isEqualToString:@"3"]){
        stoneUrlStr = self.URL;
    }else if ([self.type isEqualToString:@"5"]){
        //用户隐私
//        stoneUrlStr = @"http://121.204.136.234:48000/Yigo1.6/agreement.html";
        stoneUrlStr = [NSString stringWithFormat:@"%@/agreement.html",URL_POST_IOS];
    }else if ([self.type isEqualToString:@"6"]){
        //用户协议
//        stoneUrlStr = @"http://121.204.136.234:48000/Yigo1.6/UserAgreement.html";
        stoneUrlStr = [NSString stringWithFormat:@"%@/UserAgreement.html",URL_POST_IOS];
    }else if ([self.type isEqualToString:@"7"]){
        //市场合同
        stoneUrlStr =[NSString stringWithFormat:@"%@?billId=%ld&billKey=%@&aesKey=%@&appLoginToken=%@&username=%@&userdepartment=%@&usertime=%@&type=0&version=%lf",URL_H5_CONTRACT_IOS,(long)self.billId,@"Flow_InvestContract",aes,self.usermodel.appLoginToken,self.creatorName,@"",@"",0.0];
//        NSLog(@"=================================%@",stoneUrlStr);
    }
    else{
        stoneUrlStr =[NSString stringWithFormat:@"%@?billId=%ld&billKey=%@&aesKey=%@&appLoginToken=%@&workItemId=%ld&username=%@&userdepartment=%@&usertime=%@&type=0&version=%lf&isApproval=%@",URL_H5_IOS,(long)self.billId,self.billKey,aes,self.usermodel.appLoginToken,(long)self.workItemId,self.creatorName,self.deptName,self.usertime,self.version,self.isApproval];
    }
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
//    self.htmlView.sd_layout
//    .leftSpaceToView(self.view, 0)
//    .rightSpaceToView(self.view, 0)
//    .bottomSpaceToView(self.view, 0)
//    .topSpaceToView(self.navigationController.navigationBar, 0);
//    self.progressLineview.sd_layout
//    .leftSpaceToView(self.htmlView, 0)
//    .rightSpaceToView(self.htmlView, 0)
//    .topSpaceToView(self.htmlView, 0)
//    .heightIs(2);
    
    self.progressLineview.frame = CGRectMake(0, 0, SCW, 2);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.progressLineview.frame), SCW, self.htmlView.yj_height - CGRectGetMaxY(self.progressLineview.frame));
//    self.webView.sd_layout
//    .leftSpaceToView(self.htmlView, 0)
//    .rightSpaceToView(self.htmlView, 0)
//    .topSpaceToView(self.progressLineview, 0)
//    .bottomSpaceToView(self.htmlView, 0);
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"jump"]) {
        NSString * shareStr = message.body;
        [self jumpPageIndex:[shareStr integerValue]
         ];
    }else if ([message.name isEqualToString:@"reload"]){
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@",message.body]];
//        [self UpdateView()];
        self.UpdateView();
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"reLoadCurrentViewData" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([message.name isEqualToString:@"Submission"]){
        [self Logout];
    }else if ([message.name isEqualToString:@"Enclosure"]){
        [self jumpEnclosureTempStr:message.body];
    }else if ([message.name isEqualToString:@"annexImgClick"]){
        [self selectPicture];
    }else if ([message.name isEqualToString:@"annexFileClick"]){
        [self selectFile];
    }
}
//选择相册图片
- (void)selectPicture{
    TZImagePickerController * tzimagepicker = [[TZImagePickerController alloc]initWithMaxImagesCount:5 delegate:self];
    tzimagepicker.allowTakeVideo = NO;
    tzimagepicker.allowTakePicture = YES;
    NSMutableArray * imageArray = [NSMutableArray array];
    [tzimagepicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i=0; i<photos.count; i++)
                {
                    UIImage * tempImg = photos[i];
                    NSString * str = [self UIImageToBase64Str:tempImg];
                    NSData * data = UIImageJPEGRepresentation(tempImg, 1.0f);
                    NSString * format = [self typeForImageData:data];
                    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
                    [dict setValue:str forKey:@"content"];
                    [dict setValue:format forKey:@"format"];
                    [imageArray addObject:dict];
                }
                for (int i = 0; i < imageArray.count; i++) {
                    NSMutableDictionary * dict = imageArray[i];
                    NSString * imageStr = [dict objectForKey:@"content"];
                    NSString * format = [dict objectForKey:@"format"];
                    NSString * newImageStr = [NSString stringWithFormat:@"IOSReceiveAttachment('%@/%@')",format,imageStr];
                    [self.webView evaluateJavaScript:newImageStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    }];
                }
            });
        });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        tzimagepicker.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:tzimagepicker animated:YES completion:nil];
}

//选择icloud文件
- (void)selectFile{
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes
                                                                                                                          inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}

#pragma mark - UIDocumentPickerDelegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    NSArray * array = [[url absoluteString] componentsSeparatedByString:@"/"];
    NSString * fileName = [array lastObject];
    fileName = [fileName stringByRemovingPercentEncoding];
    if ([iCloudManager iCloudEnable]) {
        [iCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
            NSData * data = obj;
            NSString * fileStr = [self fileToToBase64Data:data];
            NSString * format = [NSString string];
            NSRange rage = [fileName rangeOfString:@"." options:NSBackwardsSearch];// NSBackwardsSearch 表示最后的一个 // 去掉options表示从第一个开始
            if (rage.location != NSNotFound) {
                format = [fileName substringFromIndex:rage.location];
            }
            //NSRange range = [fileName rangeOfString:@"."];//匹配得到的下标
            // NSString * format = [fileName substringFromIndex:range.location];
            NSString * newImageStr = [NSString stringWithFormat:@"IOSReceiveAttachment('%@/%@')",format,fileStr];
            [self.webView evaluateJavaScript:newImageStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            }];
        }];
    }
}

//图片的取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
    [self.webView evaluateJavaScript:@"annexNOSelect()" completionHandler:nil];
}

//文件取消
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller{
    
    [self.webView evaluateJavaScript:@"annexNOSelect()" completionHandler:nil];
}


- (void)Logout{
    [JXTAlertView showToastViewWithTitle:@"登录已失效"
                                 message:@"你的账号在其他手机上面登录"
                                duration:2
                       dismissCompletion:^(NSInteger buttonIndex) {
        //NSLog(@"关闭");
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSData * data = [user objectForKey:@"OAUSERMODEL"];
        RSUserModel * usermodel  = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        } seq:0];
        [user removeObjectForKey:@"OAUSERMODEL"];
        [user removeObjectForKey:@"AES"];
        [user synchronize];
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        RSLoginViewController * loginVc = [[RSLoginViewController alloc]init];
        appdelegate.window.rootViewController = loginVc;
    }];
}

- (void)jumpEnclosureTempStr:(NSString *)tempStr{
    QLPreviewController *previewController =[[QLPreviewController alloc]init];
    NSRange rage = [tempStr rangeOfString:@"/" options:NSBackwardsSearch];// NSBackwardsSearch 表示最后的一个 // 去掉options表示从第一个开始
    if (rage.location != NSNotFound) {
        //NSLog(@"%ld",rage.location);
        self.fileNewName = [tempStr substringFromIndex:rage.location+1];
        //NSLog(@"%@",tempStr);
    }
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
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
        self.fileURL = url;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            previewController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:previewController animated:YES completion:nil];
        //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
        [previewController refreshCurrentPreviewItem];
    }else {
        [SVProgressHUD showWithStatus:@"下载中"];
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
        } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
            return url;
        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
            [SVProgressHUD dismiss];
            self.fileURL = filePath;
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                previewController.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:previewController animated:YES completion:nil];
            //刷新界面,如果不刷新的话，不重新走一遍代理方法，返回的url还是上一次的url
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
    //return self.fileURL;
    QLPreviewItemCustom * previewItem = [QLPreviewItemCustom new];
    //RSSystemModel * systemmodel = self.systemArray[index];
    previewItem.previewItemTitle = self.fileNewName;
    previewItem.previewItemURL = self.fileURL;
    return previewItem;
}

//- (void)previewControllerDidDismiss:(QLPreviewController *)controller{
////    RSMyNavigationViewController * myNavi = (RSMyNavigationViewController *)self.frostedViewController.contentViewController;
////    [myNavi.images removeLastObject];
//}

- (void)jumpPageIndex:(NSInteger)billId{
    RSApprovalProcessViewController * approvalProcessVc = [[RSApprovalProcessViewController alloc]init];
    approvalProcessVc.billId = billId;
    approvalProcessVc.title = self.title;
    [self.navigationController pushViewController:approvalProcessVc animated:YES];
}

- (void)dealloc{
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"tixing"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"reload"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"Submission"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"Enclosure"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"annexImgClick"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"annexFileClick"];
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
