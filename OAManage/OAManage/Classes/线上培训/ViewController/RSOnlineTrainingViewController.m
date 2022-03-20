//
//  RSOnlineTrainingViewController.m
//  OAManage
//
//  Created by mac on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSOnlineTrainingViewController.h"
//视频内容
#import "RSOnlineContentViewController.h"

#import "RSOnlineTypeModel.h"

@interface RSOnlineTrainingViewController ()<UITextFieldDelegate,UIScrollViewDelegate>
/** 标题栏 */
@property (nonatomic,weak) UIScrollView *titleScrollView;
/** 上一次点击的按钮 */
@property (nonatomic,weak) UIButton *preTitleBtn;
/** 内容的scrollView */
@property (nonatomic,weak) UIScrollView *contentScrollView;
/** 标题按钮数组 */
@property (nonatomic,strong) NSMutableArray *titleBtns;
/** 下划线 */
@property (nonatomic,strong) UIView *underLineView;
/**获取搜索内容*/
@property (nonatomic,strong)UITextField * searchTextfield;

@property (nonatomic,strong)NSMutableArray * contentArray;


@property (nonatomic,strong)UIView * bottomView;

@end

@implementation RSOnlineTrainingViewController

#pragma mark -lazy
- (NSMutableArray *)titleBtns
{
    if (_titleBtns == nil) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        self.navigationController.navigationBar.frame = CGRectMake(0, 44, SCW, 44);
    }else{
        self.navigationController.navigationBar.frame = CGRectMake(0, 20, SCW, 44);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    self.emptyView.hidden = true;
    [self.tableview removeFromSuperview];
    
    UIView * searchView = [[UIView alloc]init];
    searchView.frame = CGRectMake(0, 0, SCW - 70, 32);
    searchView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    
    searchView.layer.cornerRadius = 5.5;
    searchView.layer.borderColor = [UIColor colorWithHexColorStr:@"#E2E2E2"].CGColor;
    searchView.layer.borderWidth = 0.5;
    
    
    //添加一个搜索框
    self.navigationItem.titleView = searchView;
    //这边添加一个输入框
    UITextField * searchTextfield = [[UITextField alloc]init];
    searchTextfield.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    searchTextfield.font = [UIFont systemFontOfSize:14];
    searchTextfield.delegate = self;
   
    [searchView addSubview:searchTextfield];
//    searchTextfield.sd_layout
//    .leftSpaceToView(searchView, 0)
//    .rightSpaceToView(searchView, 0)
//    .topSpaceToView(searchView, 0)
//    .bottomSpaceToView(searchView, 0);
    searchTextfield.frame = CGRectMake(0, 0, SCW - 72, 32);
    
    UIImageView * leftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@" system-serch"]];
       //leftImage.frame = CGRectMake(7.5, 0, 17.5, 17.5);
       
       UIView * leftView = [[UIView alloc]init];
       leftView.frame = CGRectMake(0, 0, 32.5, 32);
       [leftView addSubview:leftImage];
    
//       leftImage.sd_layout
//       .leftSpaceToView(leftView, 7.5)
//       .centerYEqualToView(leftView)
//       .widthIs(17.5)
//       .heightEqualToWidth();
    leftImage.frame = CGRectMake(7.5, 32.5/2 - 17.5/2, 17.5, 17.5);
       
    searchTextfield.leftView = leftView;
    searchTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    //清除导航栏底下的线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    

  
    [self reloadAuditedData];
}




- (void)reloadAuditedData{
    NetworkTool * network = [[NetworkTool alloc]init];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setValue:self.usermodel.appLoginToken forKey:@"loginToken"];
    RSWeakself
    //[dict setValue:URL_NEWVIDEO_IOS((long)self.pageNum,6,1,self.title) forKey:@"data"];
    [network newReloadWebServiceNoDataURL:URL_VIDEOTYPE_IOS andParameters:dict andURLName:URL_VIDEOTYPE_IOS];
    network.successArrayReload = ^(NSMutableArray *array) {
        [weakSelf.contentArray addObjectsFromArray:array];
        // 1.添加所有子控制器
        [weakSelf addAllChildVC];
        // 2.搭建标题栏视图
        [weakSelf setupTitleView];
        // 3.搭建内容视图
        [weakSelf setupContentView];
        // 4.添加标题按钮
        [weakSelf setupAllTitleButton];
        // 5.添加下划线
        [weakSelf setupUnderLineView];
    };
    
}


//创建选择框

#pragma mark - 添加下划线
- (void)setupUnderLineView
{
    // 默认选中下标为0的按钮
    UIButton *titleBtn = self.titleBtns[0];
   // titleBtn.titleLabel.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    [self titleBtnClick:titleBtn];
    //titleBtn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    // 添加下划线
    UIView *lineView = [[UIView alloc] init];
    self.underLineView = lineView;
    lineView.backgroundColor = [UIColor colorWithHexColorStr:@"#27C79A"];
    CGFloat y = self.titleScrollView.bounds.size.height -2;
    CGFloat h = 2;
    // 强制让系统计算一下titleLabel的size
    [titleBtn.titleLabel sizeToFit];
//    NSLog(@"titleLabel.frame = %@",NSStringFromCGRect(titleBtn.titleLabel.frame));
    CGFloat w = titleBtn.titleLabel.bounds.size.width + 5;
    lineView.frame = CGRectMake(0, y, w, h);
    [self.titleScrollView addSubview:lineView];
    
    // 设置下滑线centerX的值，让下划线在按钮的正下方
    CGPoint center = lineView.center;
    center.x = titleBtn.center.x;
    lineView.center = center;
    
    
}

/*
// 布局子控件，设置子控件的frame
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // 默认选中下标为0的按钮
    UIButton *titleBtn = self.titleBtns[0];
    NSLog(@"viewDidLayoutSubviews-----titleLabel.frame = %@",NSStringFromCGRect(titleBtn.titleLabel.frame));

}
 */





// 要添加多少个多少标题按钮？
// 有多少个子控制器就添加多少个标题按钮
#pragma mark - 添加标题按钮
- (void)setupAllTitleButton
{
    // 子控制器的数量
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = 0.0f;
    BOOL isExceed = false;
    CGFloat btnH = self.titleScrollView.bounds.size.height;
    for (int i = 0; i < count; i++) {
    UIViewController *vc = self.childViewControllers[i];
    CGSize size = [vc.title boundingRectWithSize:CGSizeMake(MAXFLOAT, btnH) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        btnW += size.width + 10;
    }
    if (btnW > SCW) {
        btnW = 0;
        isExceed = true;
    }else{
        //btnW = SCW/count;
        //isExceed = false;
        btnW = 0;
        isExceed = true;
    }
    for (int i = 0; i < count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        //创建标题按钮
        UIButton * btn = [[UIButton alloc] init];
        if (isExceed) {
              CGSize size = [vc.title boundingRectWithSize:CGSizeMake(MAXFLOAT, btnH) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
            btn.frame = CGRectMake(btnW, 0, size.width, btnH);
            btnW += size.width + 10;
        }else{
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        }
        // 设置按钮的标题
        // 获取按钮对应的子控制器
        [btn setTitle:vc.title forState:UIControlStateNormal];
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 设置标题按钮的文字颜色
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateSelected];
        // 添加按钮的点击事件
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
        // 给按钮设置tag
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        // 将所有的标题按钮都保存到数组里
        [self.titleBtns addObject:btn];
        // 将标题按钮添加到标题栏里
        [self.titleScrollView addSubview:btn];
    }
    //count * btnW
    // 给标题scrollView设置滚动范围
     if (isExceed) {
       self.titleScrollView.contentSize = CGSizeMake( btnW, 0);
    }else{
       self.titleScrollView.contentSize = CGSizeMake(count * btnW, 0);
    }
    // 给内容的scrollView设置滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * SCW, 0);

    
}


#pragma mark - 标题按钮点击调用
- (void)titleBtnClick:(UIButton *)titleBtn
{
    // 1.按钮点击三步曲
    [self seletedTitleBtn:titleBtn];
    // 2.要添加子控制的view
    NSInteger index = titleBtn.tag;
    [self addOneChildVcView:index];
    // 3.显示当前子控制器的view
    // 修改偏移量带动画
    [self.contentScrollView setContentOffset:CGPointMake(index * SCW, 0) animated:YES];
    
    if (self.titleScrollView.contentSize.width > SCW) {
        // 4.让标题按钮居中
          [self setTitleBtnCenter:titleBtn];
    }
    // 5.移动下滑线，让下滑线在点击按钮的正下方
    // 使用动画
    [UIView animateWithDuration:0.25 animations:^{
        // 一定要先修改下滑线的宽度，再修改下滑线的centerX值
        CGRect frame = self.underLineView.frame;
        frame.size.width = titleBtn.titleLabel.bounds.size.width + 10;
        self.underLineView.frame = frame;
        
        // 修改下滑线的centerX值
        CGPoint center = self.underLineView.center;
        center.x = titleBtn.center.x;
        self.underLineView.center = center;
    }];
}

#pragma mark - 标题按钮居中显示
- (void)setTitleBtnCenter:(UIButton *)titleBtn
{
    // 4.让标题按钮居中
    // 求出居中偏移量 = 标题按钮的centerX - 屏幕宽度的一半
    CGFloat offsetX = titleBtn.center.x - SCW * 0.5;
    // 判断极值
    // 如果求出的偏移量为负数就设置为0
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 计算最大偏移量
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - SCW;
    if (offsetX > maxOffsetX) { // 居中的偏移量不能大于最大偏移量
        offsetX = maxOffsetX;
    }
    // 设置标题栏的偏移量
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}


#pragma mark - 添加子控制器的view到contentScrollView
- (void)addOneChildVcView:(NSInteger)index
{
    // 2.1获取按钮对应的子控制器
    UIViewController *vc = self.childViewControllers[index];
    // 如果子控制器的view已经添加过了，就不要重复添加了
    // 如何判断子控制器的view有没有添加过？
    // 判断条件：判断子控制器的view有没有父控件,如果已经添加过了，就有父控件，否则没有没有。
    if (vc.view.superview) { // 如果父控件存在就说明已经添加过了，就不需要再添加了
        return;
    }
    CGFloat x = index * SCW;
    // 2.2设置子控制器view的frame
    vc.view.frame = CGRectMake(x, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
    // 2.2将子控制器的view添加到内容的scrollView里
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark - 选中标题按钮
- (void)seletedTitleBtn:(UIButton *)titleBtn
{
    
    self.preTitleBtn.selected = NO;
       titleBtn.selected = YES;
       self.preTitleBtn = titleBtn;
       NSInteger tag = titleBtn.tag;
       // 2.处理下滑线的移动
       [UIView animateWithDuration:0.25 animations:^{
           self.underLineView.yj_width = titleBtn.titleLabel.yj_width;
           self.underLineView.yj_centerX = titleBtn.yj_centerX;
           
           // 3.修改contentScrollView的便宜量,点击标题按钮的时候显示对应子控制器的view
           self.contentScrollView.contentOffset = CGPointMake(tag * self.contentScrollView.yj_width, 0);
       }];
       
       // 添加子控制器的view
       UIViewController *vc = self.childViewControllers[tag];
       // 如果子控制器的view已经添加过了，就不需要再添加了
       if (vc.view.superview) {
           return;
       }
       vc.view.frame = CGRectMake(tag * SCW, 0, SCW, SCH);
       [self.contentScrollView addSubview:vc.view];
    
    
    
//    // 1.1将上一次点击的按钮的文字修改为黑色
//    [self.preTitleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    // 1.2让当前点击的按钮文字变成红色
//    [titleBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
//    // 1.3将当前点击的按钮赋值给上一次点击的按钮
//    self.preTitleBtn = titleBtn;
}



#pragma mark - 搭建内容视图
- (void)setupContentView
{   // 创建内容scrollView
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    // 设置背景颜色
//    contentScrollView.backgroundColor = [UIColor greenColor];
    // 设置内容的frame
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.bottomView.frame);
    CGFloat w = SCW;
    CGFloat h = SCH - y;
    contentScrollView.frame = CGRectMake(x, y, w, h);
    // 添加到控制器的view里
    [self.view addSubview:contentScrollView];
    
    // 设置contentScrollView分页效果
    contentScrollView.pagingEnabled = YES;
    // 设置代理
    contentScrollView.delegate = self;
    
}


#pragma mark - 搭建标题栏视图
- (void)setupTitleView
{
    // 创建标题栏
    UIScrollView *titleScrollView = [[UIScrollView alloc] init];
    self.titleScrollView = titleScrollView;
    // 设置背景颜色
//    titleScrollView.backgroundColor = [UIColor redColor];
    // 设置标题栏的frame
    CGFloat x = 0;
    CGFloat y = 0.0f;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        y = 88;
    }else{
        y = 64;
    }
    CGFloat w = SCW;
    CGFloat h = 44.5;
    titleScrollView.frame = CGRectMake(x, y, w, h);
    // 添加到控制器的view里
    [self.view addSubview:titleScrollView];
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexColorStr:@"#E6E6E6"];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(titleScrollView.frame), SCW, 0.5);
    [self.view addSubview:bottomView];
    _bottomView = bottomView;
    // 去掉scollView的滚动条
    titleScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 添加所有子控制器
- (void)addAllChildVC
{
    //自己添加一条数据，为全部的数据
    RSOnlineTypeModel * onlineTypemodel = [[RSOnlineTypeModel alloc]init];
    onlineTypemodel.onlineTypeId = 0;
    onlineTypemodel.name = @"  全部";
    [self.contentArray insertObject:onlineTypemodel atIndex:0];
    
    for (int i = 0; i < self.contentArray.count; i++) {
        RSOnlineContentViewController * Vc = [[RSOnlineContentViewController alloc]init];
        RSOnlineTypeModel * onlineTypemodel = self.contentArray[i];
        Vc.view.tag = onlineTypemodel.onlineTypeId;
        Vc.title = onlineTypemodel.name;
        Vc.searchStr = @"";
        [self addChildViewController:Vc];
    }
    NSInteger count = self.childViewControllers.count;
    // 设置内容scrollView的滚动范围
    self.contentScrollView.contentSize = CGSizeMake(count * self.contentScrollView.yj_width, 0);
}

#pragma mark - <UIScrollViewDelegate>代理
// UIScrollView由于惯性会继续的往前滚动一段距离
// 当scrollView减速结束的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 1.选中对应标题按钮 2.添加对应的子控制器的view
    // 首先获取对应的标题按钮
    // 获取对应子控制器的下标，也就是标题按钮在数组里的下标
    NSInteger index = scrollView.contentOffset.x / SCW;
    // 根据对应子控制器的下标获取子控制器对应的标题按钮
    UIButton *titleBtn = self.titleBtns[index];
    // 直接调用标题按钮的点击事件
    [self titleBtnClick:titleBtn];
    
}

// 当scrollView滚动的时候就调用这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"scrollView滚动-----");
    // 要计算出按钮文字的缩放比例
    // 1.获取到左边的按钮和右边的按钮
    // 2.计算出这2个按钮的缩放比例
    
    // 首先获取左边的标题按钮
    // 获取左边标题按钮的下标
//    NSInteger leftIndex = scrollView.contentOffset.x / SCW;
//    // 获取右边标题按钮的下标
//    NSInteger rightIndex = leftIndex + 1;
//    // 根据下标获取左边标题按钮
//    UIButton *leftBtn = self.titleBtns[leftIndex];
//    // 根据下标获取右边标题按钮
//    UIButton *rightBtn = nil;
//    // 判断极值,右边按钮的下标要小于数组count
//    if (rightIndex < self.titleBtns.count) {
//        rightBtn = self.titleBtns[rightIndex];
//    }
//
//    // 计算出右边按钮的缩放比例 取值(0~1)
//    CGFloat rightRatio = scrollView.contentOffset.x / SCW;
////    // 减去左边标题按钮的下标，保留小数部分，去掉整数部分
//    rightRatio = rightRatio - leftIndex;
//
//    // 计算出左边按钮的缩放比例 取值(0~1)
//    CGFloat leftRatio = 1 - rightRatio;
//
//    // 设置按钮文字的缩放,文字的缩放倍数 1~1.3倍
//    leftBtn.transform = CGAffineTransformMakeScale(1 + 0.3 * leftRatio, 1 + 0.3 * leftRatio);
//    rightBtn.transform = CGAffineTransformMakeScale(1 + 0.3 * rightRatio, 1 + 0.3 * rightRatio);
//
//    [leftBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    [rightBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//
    // 计算拖拽的比例
      CGFloat ratio = scrollView.contentOffset.x / scrollView.yj_width;
      // 将整数部分减掉，保留小数部分的比例(控制器比例的范围0~1.0)
      ratio = ratio - self.preTitleBtn.tag;
      
      // 设置下划线的centerX
      self.underLineView.yj_centerX = self.preTitleBtn.yj_centerX + ratio * self.preTitleBtn.yj_width;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    NSLog(@"---------%@",textField.text);//文本彻底结束编辑时调用
    NSInteger index = self.contentScrollView.contentOffset.x / SCW;
//    NSLog(@"================%ld",index);
    RSOnlineContentViewController * onlineContent = self.childViewControllers[index];
    onlineContent.searchStr = textField.text;
    [onlineContent.tableview.mj_header beginRefreshing];
}



//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return NO;
//}
//
//- (BOOL)prefersHomeIndicatorAutoHidden {
//    return NO;
//}


@end
