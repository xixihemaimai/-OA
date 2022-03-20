//
//  RSTouchAlertView.m
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTouchAlertView.h"


@interface RSTouchAlertView()<UITextViewDelegate>

@property(nonatomic,strong)UIView *bgView;


@property(nonatomic,strong)UITextView * materielTextview;

@property(nonatomic,strong)UITextView * blockTextview;

@end


@implementation RSTouchAlertView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
     
        
        
        
        
    }
    return self;
}



- (void)createView{
    
    
    UIButton * cancelBtn = [[UIButton alloc]init];
    [cancelBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    
    //筛选条件
    UILabel * screenLabel = [[UILabel alloc]init];
    screenLabel.text = @"筛选条件";
    screenLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    screenLabel.textAlignment = NSTextAlignmentCenter;
    screenLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:screenLabel];
    
    
    //物料名称
    UILabel * materielNameLabel = [[UILabel alloc]init];
    materielNameLabel.text = @"物料名称";
    materielNameLabel.textAlignment = NSTextAlignmentLeft;
    materielNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    materielNameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:materielNameLabel];
    
    //物料
    UITextView * materielTextview = [[UITextView alloc]init];
    materielTextview.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    materielTextview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    materielTextview.layer.cornerRadius = 17;
    materielTextview.delegate = self;
    materielTextview.font = [UIFont systemFontOfSize:16];
    materielTextview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
    materielTextview.layer.masksToBounds = YES;
    materielTextview.returnKeyType = UIReturnKeySend;
    [self addSubview:materielTextview];
    _materielTextview = materielTextview;
    
    //荒料号
    UILabel * blockNameLabel = [[UILabel alloc]init];
    blockNameLabel.text = @"荒料号";
    blockNameLabel.textAlignment = NSTextAlignmentLeft;
    blockNameLabel.textColor = [UIColor colorWithHexColorStr:@"#666666"];
    blockNameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:blockNameLabel];
    
    //物料
    UITextView * blockTextview = [[UITextView alloc]init];
    blockTextview.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    blockTextview.backgroundColor = [UIColor colorWithHexColorStr:@"#F7F7F7"];
    blockTextview.layer.cornerRadius = 17;
    blockTextview.delegate = self;
    blockTextview.font = [UIFont systemFontOfSize:16];
    blockTextview.textContainerInset = UIEdgeInsetsMake(5, 10, 0, 0);
    blockTextview.layer.masksToBounds = YES;
    blockTextview.returnKeyType = UIReturnKeySend;
    [self addSubview:blockTextview];
    _blockTextview = blockTextview;
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [self addSubview:view];
    
    UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.bounds.size.width/2 - 0.5, 47);
    [buttonOne setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonOne setTitle:@"重置" forState:UIControlStateNormal];
    [buttonOne addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonOne];
    
    UIView * midView = [[UIView alloc]init];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [self addSubview:midView];
    
    UIButton *buttonTwo = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonTwo.frame = CGRectMake(CGRectGetMaxX(midView.frame), CGRectGetMaxY(view.frame),  self.bounds.size.width/2 - 0.5, 47);
    [buttonTwo setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonTwo setTitle:@"确定" forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(sendSalertAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buttonTwo];
    
    
//    cancelBtn.sd_layout
//    .rightSpaceToView(self, 12)
//    .topSpaceToView(self, 12)
//    .widthIs(28)
//    .heightEqualToWidth();
    
    cancelBtn.frame = CGRectMake(self.frame.size.width - 12 - 28, 12, 28, 28);
    
//
//    screenLabel.sd_layout
//    .leftSpaceToView(self, 12)
//    .rightSpaceToView(self, 12)
//    .topSpaceToView(self, 33.5)
//    .heightIs(28);
    
    screenLabel.frame = CGRectMake(12, 33.5, self.frame.size.width - 24, 28);
    
//    materielNameLabel.sd_layout
//    .leftSpaceToView(self , 40)
//    .rightSpaceToView(self, 40)
//    .heightIs(22.5)
//    .topSpaceToView(screenLabel, 15);
    materielNameLabel.frame = CGRectMake(40, CGRectGetMaxY(screenLabel.frame) + 15, self.frame.size.width - 80, 22.5);
    
    
//    materielTextview.sd_layout
//    .leftEqualToView(materielNameLabel)
//    .rightEqualToView(materielNameLabel)
//    .topSpaceToView(materielNameLabel, 5)
//    .heightIs(34);
    
    materielTextview.frame = CGRectMake(40, CGRectGetMaxY(materielNameLabel.frame) + 5, self.frame.size.width - 80, 34);
    
//    blockNameLabel.sd_layout
//    .leftEqualToView(materielTextview)
//    .rightEqualToView(materielTextview)
//    .topSpaceToView(materielTextview, 10)
//    .heightIs(22.5);
    
    blockNameLabel.frame = CGRectMake(40, CGRectGetMaxY(materielTextview.frame) + 10, self.frame.size.width - 80, 22.5);
    
//    blockTextview.sd_layout
//    .leftEqualToView(blockNameLabel)
//    .rightEqualToView(blockNameLabel)
//    .topSpaceToView(blockNameLabel, 5)
//    .heightIs(34);
    
    blockTextview.frame = CGRectMake(40, CGRectGetMaxY(blockNameLabel.frame) + 5, self.frame.size.width - 80, 34);
    
    
//    view.sd_layout
//    .leftSpaceToView(self, 0)
//    .rightSpaceToView(self, 0)
//    .heightIs(0.5)
//    .topSpaceToView(blockTextview, 20);
    
    
    view.frame = CGRectMake(0, CGRectGetMaxY(blockTextview.frame) + 20, self.frame.size.width, 0.5);
    
//    buttonOne.sd_layout
//    .leftSpaceToView(self, 0)
//    .topSpaceToView(view, 0)
//    .bottomSpaceToView(self, 0)
//    .widthIs(self.yj_width/2 - 0.5);
    
    buttonOne.frame = CGRectMake(0, CGRectGetMaxY(view.frame), self.frame.size.width/2 - 0.5, 40);
    
    
//    buttonTwo.sd_layout
//    .rightSpaceToView(self, 0)
//    .topSpaceToView(view, 0)
//    .bottomSpaceToView(self, 0)
//    .widthIs(self.yj_width/2 - 0.5);
    
    buttonTwo.frame = CGRectMake(self.frame.size.width/2 + 0.5, CGRectGetMaxY(view.frame), self.frame.size.width/2 - 0.5, 40);
    
//    midView.sd_layout
//    .leftSpaceToView(buttonOne, 0)
//    .rightSpaceToView(buttonTwo, 0)
//    .topSpaceToView(view,5)
//    .bottomSpaceToView(self, 5);
    
    
    
    midView.frame = CGRectMake(CGRectGetMaxX(buttonOne.frame), CGRectGetMaxY(view.frame) + 5, 1, 35);
}




- (void)showView
{
    
//    if ([self.selectType isEqualToString:@"edit"]) {
//        //编辑
//
//
//    }else{
//        //新建
//        self.index = 0;
//        self.secondIndex = 0;
//    }
   
    if (self.bgView) {
        return;
    }
    
    [self createView];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.bgView addGestureRecognizer:tap];
    self.bgView.userInteractionEnabled = YES;
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.4;
    [window addSubview:self.bgView];
    [window addSubview:self];
    
}
-(void)tap:(UIGestureRecognizer *)tap
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [self removeFromSuperview];
}


- (void)cancelAction:(UIButton *)cancelBtn{
    [self closeView];
}

- (void)closeView
{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    [IQKeyboardManager sharedManager].enable = YES;
    [self removeFromSuperview];
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            if (textView == _materielTextview) {
                NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                temp = [self delSpaceAndNewline:temp];
                if ([temp length] < 1){
                    _materielTextview.text = @"";
                    [_materielTextview resignFirstResponder];
                }else{
                    _materielTextview.text = temp;
                    [_materielTextview resignFirstResponder];
                }
            }else{
                NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                temp = [self delSpaceAndNewline:temp];
                if ([temp length] < 1){
                    _blockTextview.text = @"";
                    [_blockTextview resignFirstResponder];
                }else{
                    _blockTextview.text = temp;
                    [_blockTextview resignFirstResponder];
                }
            }
            return NO;
        }
        return YES;
}


//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//}

- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//重置
- (void)resetAction:(UIButton *)buttonOne{
    _materielTextview.text = @"";
    _blockTextview.text = @"";
    if ([self.delegate respondsToSelector:@selector(inputName:andBlockName:)]) {
        [self.delegate inputName:_materielTextview.text andBlockName:_blockTextview.text];
    }
     [self closeView];
}


- (void)sendSalertAction:(UIButton *)buttonTwo{
    
    if ([self.delegate respondsToSelector:@selector(inputName:andBlockName:)]) {
        [self.delegate inputName:_materielTextview.text andBlockName:_blockTextview.text];
    }
    [self closeView];
    
}


@end
