//
//  RSSalertView.m
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSalertView.h"
#import "SHESelectTable.h"
@interface RSSalertView()<UITextViewDelegate>



@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)SHESelectTable *sTable;
@end


@implementation RSSalertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       // [self createView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}

- (void)createView{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    self.clipsToBounds = YES;
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, self.bounds.size.width, 28)];
    //titleLabel.text = @"今日计划";
    titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    //取消
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(self.bounds.size.width - 28 - 8, 9.5, 28, 28);
    [cancelBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    //重要程度
    UILabel * degreeLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(titleLabel.frame) + 8, self.bounds.size.width - 80, 22)];
    degreeLabel.text = @"重要程度";
    degreeLabel.textAlignment = NSTextAlignmentLeft;
    degreeLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    degreeLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:degreeLabel];
    
    //选择
    UIButton * choiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(degreeLabel.frame) + 5, self.bounds.size.width - 80, 34)];
    [choiceBtn setTitle:@"低" forState:UIControlStateNormal];
    [choiceBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    choiceBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [choiceBtn addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    choiceBtn.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    [self addSubview:choiceBtn];
    choiceBtn.layer.cornerRadius = 17;
    choiceBtn.layer.masksToBounds = YES;
    _choiceBtn = choiceBtn;

    //具体内容
    UILabel * contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(choiceBtn.frame) + 5, self.bounds.size.width - 80, 22)];
    contentLabel.text = @"具体内容";
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    contentLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:contentLabel];
    
    //具体内容的输入项
    UITextView * contentTextview = [[UITextView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(contentLabel.frame) + 5, self.bounds.size.width - 80, 68)];
    contentTextview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    contentTextview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
    contentTextview.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    contentTextview.returnKeyType = UIReturnKeySend;
    contentTextview.delegate = self;
    [self addSubview:contentTextview];
    _contentTextview = contentTextview;
    contentTextview.layer.cornerRadius = 3;
    contentTextview.layer.masksToBounds = YES;
    
    //输出结果
    UILabel * resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(contentTextview.frame) + 5, self.bounds.size.width - 30, 20)];
    resultLabel.text = @"输出结果";
    resultLabel.textAlignment = NSTextAlignmentLeft;
    resultLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    resultLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:resultLabel];
    
    //具体内容的输入项
    UITextView * resultTextview = [[UITextView alloc]initWithFrame:CGRectMake(40, CGRectGetMaxY(resultLabel.frame) + 5, self.bounds.size.width - 80, 68)];
    resultTextview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    resultTextview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
    resultTextview.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    resultTextview.returnKeyType = UIReturnKeySend;
    resultTextview.delegate = self;
    [self addSubview:resultTextview];
    _resultTextview = resultTextview;
    resultTextview.layer.cornerRadius = 3;
    resultTextview.layer.masksToBounds = YES;
    
    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 48, self.bounds.size.width, 1)];
    bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addSubview:bottomview];
    
    //删除
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#6666666"] forState:UIControlStateNormal];
    deleteBtn.frame = CGRectMake(0, self.bounds.size.height - 47, self.bounds.size.width/2 - 0.5, 47);
    [deleteBtn addTarget:self action:@selector(deleteSalertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    
    
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(deleteBtn.frame), CGRectGetMaxY(bottomview.frame) + 8.5, 1, 30)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
    [self addSubview:midView];
    
    
    
    UIButton * sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#6666666"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureSalertAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.frame = CGRectMake(CGRectGetMaxX(midView.frame), self.bounds.size.height - 47, self.bounds.size.width/2 - 0.5, 47);
    [self addSubview:sureBtn];
}


- (void)showView
{
    if (self.bgView) {
        return;
    }
    [self createView];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
}

-(void)tap:(UIGestureRecognizer *)tap
{
    [self closeView];
}

- (void)cancelAction:(UIButton *)cancelBtn{
    [self closeView];
}

- (void)closeView
{
    [self.sTable removeFromSuperview];
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    //[[[UIApplication sharedApplication].keyWindow viewWithTag:6521] removeFromSuperview];
}
//选择低，或中，高
- (void)selectButtonClick:(UIButton *)sender{
    NSArray *seleArray=@[@"低",@"中",@"高"];
    //获取某个控件在屏幕上的位置
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect=[sender convertRect: sender.bounds toView:window];
    SHESelectTable * sTable=[[SHESelectTable alloc]initWithFrame:CGRectMake(rect.origin.x, 0, rect.size.width, self.frame.size.height) withTableFrame:CGRectMake(0, rect.origin.y + sender.frame.size.height, rect.size.width, 44 * seleArray.count) withDataArray:seleArray withSelectindex:_select];
    sTable.selTable.frame=CGRectMake(0, rect.origin.y + sender.frame.size.height, rect.size.width, 44*seleArray.count);
    //block回调
    _sTable = sTable;
    sTable.returnBlock=^(NSString *cityString,NSInteger selectIndex)
    {
        self.select = selectIndex;
        [self.sTable removeFromSuperview];
        [sender setTitle:cityString forState:UIControlStateNormal];
    };
    //弹出select table
    [[UIApplication sharedApplication].keyWindow addSubview:sTable];
    [UIView animateWithDuration:0.2 animations:^{
        sTable.selTable.alpha=1;
    }];
}

- (void)cancelSelectAction:(UIButton *)cancelBtn{
    [self closeView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        if (textView == _contentTextview) {
            NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp = [self delSpaceAndNewline:temp];
            if ([temp length] < 1){
                _contentTextview.text = @"";
                [_contentTextview resignFirstResponder];
            }else{
                _contentTextview.text = temp;
                [_contentTextview resignFirstResponder];
            }
        }else{
            NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            temp = [self delSpaceAndNewline:temp];
            if ([temp length] < 1){
                _resultTextview.text = @"";
                [_resultTextview resignFirstResponder];
            }else{
                _resultTextview.text = temp;
                [_resultTextview resignFirstResponder];
            }
        }
        return NO;
    }
    return YES;
}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
#pragma mark -- 显示键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset = kbHeight;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(33,self.frame.size.height/16, SCW - 66 , 428);
        }];
    }
}
#pragma mark ---- 当键盘消失后，视图需要恢复原状
///键盘消失事件
- (void)keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(33, (SCH/2) - 214, SCW - 66, 428);
    }];
}
//删除
- (void)deleteSalertAction:(UIButton *)deleteBtn{
    if ([self.addType isEqualToString:@"add"]) {
        //添加
         [self closeView];
    }else{
        //这边是修改的情况
        //删除
        if ([self.delegate respondsToSelector:@selector(deleteSalertViewContentIndexpath:andType:)]) {
            [self.delegate deleteSalertViewContentIndexpath:self.indexpath andType:self.addType];
        }
        [self closeView];
    }
}
//确定
- (void)sureSalertAction:(UIButton *)sureBtn{
    NSString *temp = [_contentTextview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] < 1){
        jxt_showToastMessage(@"请输入具体内容", 0.75);
        return;
    }
    NSString *temp1 = [_resultTextview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
       temp1 = [self delSpaceAndNewline:temp1];
    if ([temp1 length] < 1) {
        jxt_showToastMessage(@"请输入输出结果的内容", 0.75);
        return;
    }
    if ([self.delegate respondsToSelector:@selector(backSalertViewDataWithTitle:andChoiceTitle:andSelect:andContentTextview:andResultTextview:andIndexpath:andAddType:)]) {
        [self.delegate backSalertViewDataWithTitle:_titleLabel.text andChoiceTitle:_choiceBtn.currentTitle andSelect:self.select andContentTextview:_contentTextview.text andResultTextview:_resultTextview.text andIndexpath:self.indexpath andAddType:self.addType];
    }
    [self closeView];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
