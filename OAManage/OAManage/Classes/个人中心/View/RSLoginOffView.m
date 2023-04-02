//
//  RSLoginOffView.m
//  OAManage
//
//  Created by 杨冰 on 2023/3/31.
//  Copyright © 2023 mac. All rights reserved.
//

#import "RSLoginOffView.h"

@interface RSLoginOffView()


@property (nonatomic,strong)UITextField * passwordTextfield;




@end

@implementation RSLoginOffView



- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor colorWithHexColorStr:@"#d6d6d6" alpha:0.5];
        
        
        UIView * contentview = [[UIView alloc]init];
        contentview.frame = CGRectMake(10, SCH/2 - 100, SCW - 20, 200);
        contentview.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentview];
        
        UIButton * deleteBtn = [[UIButton alloc]init];
        deleteBtn.frame = CGRectMake(contentview.width - 40, 10, 30, 30);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [contentview addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        
     
        UILabel * titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"请输入密码即可注销账号";
        titleLabel.frame = CGRectMake(0, 10, contentview.width, 30);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [contentview addSubview:titleLabel];
        
        _passwordTextfield = [[UITextField alloc]init];
        _passwordTextfield.frame = CGRectMake(10, contentview.height/2 - 25, contentview.width - 20, 50);
        _passwordTextfield.layer.cornerRadius = 5;
        _passwordTextfield.backgroundColor = [UIColor colorWithHexColorStr:@"#d6d6d6" alpha:0.5];
        _passwordTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _passwordTextfield.placeholder = @"请输入旧密码";
        [contentview addSubview:_passwordTextfield];
        
        
        UIView * midview = [[UIView alloc]init];
        midview.frame = CGRectMake(0, 149, contentview.width, 1);
        midview.backgroundColor = [UIColor colorWithHexColorStr:@"#d6d6d6" alpha:0.5];
        [contentview addSubview:midview];
        
        
        
        
        UIButton * cancelBtn = [[UIButton alloc]init];
        cancelBtn.frame = CGRectMake(0, 150, contentview.width/2 - 1, 50);
        [cancelBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [contentview addSubview:cancelBtn];
        
        
        UIView * bottomview = [[UIView alloc]init];
        bottomview.frame = CGRectMake(contentview.width/2 - 0.5, 150, 1, 50);
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#d6d6d6" alpha:0.5];
        [contentview addSubview:bottomview];
        
        
        UIButton * sureBtn = [[UIButton alloc]init];
        sureBtn.frame = CGRectMake(contentview.width/2 - 1, 150, contentview.width/2 - 1, 50);
        [sureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        [contentview addSubview:sureBtn];
        
        
    }
    return self;
}


- (void)deleteAction{
    [self removeFromSuperview];
}

- (void)cancelAction{
    if (self.inputPassword){
        self.inputPassword(@"", false);
    }
  [self removeFromSuperview];
}

- (void)sureAction{
    if (_passwordTextfield.text.length < 1){
       [SVProgressHUD showErrorWithStatus:@"请输入旧密码"];
      return;
    }
    if (self.inputPassword){
        self.inputPassword(_passwordTextfield.text, true);
    }
    [self removeFromSuperview];
}

@end
