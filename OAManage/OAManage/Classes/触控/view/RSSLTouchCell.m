//
//  RSSLTouchCell.m
//  OAManage
//
//  Created by mac on 2019/12/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSLTouchCell.h"


@interface RSSLTouchCell()<UIScrollViewDelegate>

/// 标题的背景
@property (nonatomic, strong) UIView *backView;
/// 标题
//@property (nonatomic, strong) UILabel *titleLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *deleteButton;


@end


@implementation RSSLTouchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#f5f5f5"];
        
        [self setupCell];
        
        
        
    }
    return self;
}


-(void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    /// 在cell上先添加滑动视图
    [self.contentView addSubview:self.mainScrollView];
    
    /// 再在滑动视图上添加背景视图（就是cell主要显示的内容）
    [self.mainScrollView addSubview:self.backView];
    [self.mainScrollView addSubview:self.deleteButton];
    //[self.backView addSubview:self.titleLabel];
    
   
    self.mainScrollView.frame = CGRectMake(12, 0, SCW - 24, 70.5);
    self.backView.frame = CGRectMake(0 ,0, SCW - 24, 60.5);
    //self.titleLabel.frame = CGRectMake(10, 0, 200, 40);
    self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith], 60.5);
    
    
    
    UIView * blueView = [[UIView alloc]init];
    blueView.backgroundColor = [UIColor colorWithHexColorStr:@"#27c79a"];
    blueView.frame = CGRectMake(13, 10, 3, 13);
    [self.backView addSubview:blueView];
    
    //片号
    UILabel * filmNumberLabel = [[UILabel alloc]init];
    filmNumberLabel.frame = CGRectMake(20, 6, 120, 20);
    filmNumberLabel.text = [NSString stringWithFormat:@"片号%d",1];
    filmNumberLabel.font = [UIFont systemFontOfSize:14];
    filmNumberLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    filmNumberLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:filmNumberLabel];
    _filmNumberLabel = filmNumberLabel;
    //长
    UILabel * longLabel = [[UILabel alloc]init];
    longLabel.frame = CGRectMake(20, CGRectGetMaxY(filmNumberLabel.frame) + 7.5, 80, 20);
    longLabel.text = @"面积(m²)";
    longLabel.font = [UIFont systemFontOfSize:14];
    longLabel.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    longLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:longLabel];
    
    
    //长的值
    UILabel * longDetailLabel = [[UILabel alloc]init];
    longDetailLabel.font = [UIFont systemFontOfSize:14];
   // CGSize size = [self obtainLabelTextSize:@"0.11" andFont:longDetailLabel.font];
    longDetailLabel.frame = CGRectMake(CGRectGetMaxX(longLabel.frame) + 14, CGRectGetMaxY(filmNumberLabel.frame) + 7.5, SCW - CGRectGetMaxX(longLabel.frame) - 14, 20);
    longDetailLabel.text = @"0.11";
    
    
    longDetailLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    longDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:longDetailLabel];
    _longDetailLabel = longDetailLabel;
    
    
}









//- (CGSize)obtainLabelTextSize:(NSString *)text andFont:(UIFont *)font{
//    CGSize size = [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT)
//                                     options:NSStringDrawingUsesLineFragmentOrigin
//                                  attributes:@{NSFontAttributeName:font}
//                                     context:nil].size;
//    return size;
//}


//#pragma mark - Set方法
//-(void)setName:(NSString *)name {
//    _name = name;
//
//    self.titleLabel.text = [NSString stringWithFormat:@"这里有个%@", self.name];
//}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint movePoint = self.mainScrollView.contentOffset;
    if (movePoint.x < 0) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    }
    if (movePoint.x > [self deleteButtonWdith]) {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, movePoint.x, 60.5);
    } else {
        self.deleteButton.frame = CGRectMake(self.backView.yj_x + self.backView.yj_width, 0, [self deleteButtonWdith], 60.5);
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint endPoint = self.mainScrollView.contentOffset;
    if (endPoint.x < self.deleteButtonWdith) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (self.scrollAction) {
        self.scrollAction();
    }
}

#pragma mark - 点击事件
-(void)deleteAction:(UIButton *)button {
    if (self.deleteAction) {
        self.deleteAction(self.indexPath);
    }
}

#pragma mark - Get方法
-(CGFloat)deleteButtonWdith {
    return 60.0 * (SCW / 375.0);
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithHexColorStr:@"#F9F9F9"];
    }
    
    return _backView;
}

//-(UILabel *)titleLabel {
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] init];
//    }
//    return _titleLabel;
//}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        /// 设置滑动视图的偏移量是：屏幕宽+删除按钮宽
        _mainScrollView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        _mainScrollView.contentSize = CGSizeMake(self.deleteButtonWdith + SCW, 0);
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.delegate = self;
        _mainScrollView.bounces = NO;
        _mainScrollView.userInteractionEnabled = YES;
    }
    
    return _mainScrollView;
}

-(UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteButton.backgroundColor = [UIColor colorWithHexColorStr:@"#FDAD32"];
        [_deleteButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _deleteButton;
}

/// 判断是否被打开了
-(BOOL)isOpen {
    return self.mainScrollView.contentOffset.x >= self.deleteButtonWdith;
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
