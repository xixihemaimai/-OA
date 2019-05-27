//
//  JJOptionView.m
//  DropdownListDemo
//
//  Created by 俊杰  廖 on 2018/9/20.
//  Copyright © 2018年 HoYo. All rights reserved.
//

#import "JJOptionView.h"
#import <Masonry.h>
#import "RSRoleModel.h"
#define WEAKSELF __weak typeof(self) weakSelf = self;

@interface JJOptionView ()<UITableViewDelegate,UITableViewDataSource>

/**
 标题控件
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 右边箭头图片
 */
@property (nonatomic, strong) UIImageView *rightImageView;

/**
 控件透明按钮，也可以给控件加手势
 */
@property (nonatomic, strong) UIButton *maskBtn;

/**
 选项列表
 */
@property (nonatomic, strong) UITableView *tableView;

/**
 蒙版
 */
@property (nonatomic, strong) UIButton *backgroundBtn;
/**
 tableView的高度
 */
@property (nonatomic, assign) CGFloat tableViewHeight;
@property (nonatomic, assign) BOOL isDirectionUp;


/**组头视图*/
@property (nonatomic,strong)UIView * headerview;

/**方向图片*/
@property (nonatomic,strong)UIImageView * headerImage;

@end

static CGFloat const animationTime = 0.3;
static CGFloat const rowheight = 42;

@implementation JJOptionView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource {
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataSource;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    self.cornerRadius = 20;
    self.borderWidth = 1;
    self.borderColor = [UIColor colorWithHexColorStr:@"#D3D3D3"];
    
    [self addSubview:self.rightImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.maskBtn];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-24);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
        //make.left.equalTo(self.mas_left).offset(10);
        //make.right.equalTo(self.rightImageView);
    }];
    [self.maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}





- (void)show {
    WEAKSELF;
    if (self.dataSource.count < 1) {
        [SVProgressHUD showInfoWithStatus:@"请先输入正确的用户名，在选择你需要的角色"];
    }else{
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.backgroundBtn];
        [window addSubview:self.tableView];
        [window addSubview:self.headerview];
        [window addSubview:self.headerImage];
        // 获取按钮在屏幕中的位置
        CGRect frame = [self convertRect:self.bounds toView:window];
        CGFloat tableViewY = frame.origin.y + frame.size.height;
        CGRect tableViewFrame;
        tableViewFrame.size.width = frame.size.width - 20;
        tableViewFrame.size.height = self.tableViewHeight;
        tableViewFrame.origin.x = frame.origin.x + 10;

        if (tableViewY + self.tableViewHeight < CGRectGetHeight([UIScreen mainScreen].bounds)) {
            tableViewFrame.origin.y = tableViewY;
            self.isDirectionUp = NO;
        }else {
            tableViewFrame.origin.y = frame.origin.y - self.tableViewHeight;
            self.isDirectionUp = YES;
        }
        self.headerview.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y +(self.isDirectionUp?self.tableViewHeight:0), tableViewFrame.size.width, 0);
        self.headerImage.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y +(self.isDirectionUp?self.tableViewHeight:0), tableViewFrame.size.width, 0);
        self.tableView.frame = CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y +(self.isDirectionUp?self.tableViewHeight:0), tableViewFrame.size.width, 0);
        [UIView animateWithDuration:animationTime animations:^{
           // weakSelf.rightImageView.transform = CGAffineTransformRotate(weakSelf.rightImageView.transform,self.isDirectionUp ? 0 : -M_PI);
             weakSelf.headerview.frame =  CGRectMake(tableViewFrame.origin.x, tableViewFrame.origin.y, tableViewFrame.size.width, 7);
            weakSelf.headerImage.frame = CGRectMake(frame.size.width + 17, tableViewFrame.origin.y, 12, 7);
            weakSelf.tableView.frame = CGRectMake(tableViewFrame.origin.x, CGRectGetMaxY(weakSelf.headerview.frame), tableViewFrame.size.width, tableViewFrame.size.height + 7);
            //NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
        }];
    }
}

- (void)dismiss {
    WEAKSELF;
    [UIView animateWithDuration:animationTime animations:^{
       // weakSelf.rightImageView.transform = CGAffineTransformIdentity;
        weakSelf.tableView.frame = CGRectMake(weakSelf.tableView.frame.origin.x, weakSelf.tableView.frame.origin.y+(self.isDirectionUp?self.tableViewHeight:0), weakSelf.tableView.frame.size.width, 0);
        weakSelf.headerview.frame = CGRectMake(weakSelf.tableView.frame.origin.x, weakSelf.tableView.frame.origin.y+(self.isDirectionUp?self.tableViewHeight:0), weakSelf.tableView.frame.size.width, 0);
        weakSelf.headerImage.frame =CGRectMake(weakSelf.tableView.frame.origin.x, weakSelf.tableView.frame.origin.y+(self.isDirectionUp?self.tableViewHeight:0), weakSelf.tableView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [weakSelf.backgroundBtn removeFromSuperview];
        [weakSelf.tableView removeFromSuperview];
        [weakSelf.headerview removeFromSuperview];
        [weakSelf.headerImage removeFromSuperview];
    }];
    
}


#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    RSRoleModel * rolemodel = self.dataSource[indexPath.row];
    
    //cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.text = rolemodel.name;
    cell.textLabel.textColor = [UIColor colorWithHexColorStr:@"#FFFFFF"];
    cell.backgroundColor = [UIColor colorWithHexColorStr:@"#00D19C"];
    cell.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#00D19C"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //self.title = self.dataSource[indexPath.row];
     [self.tableView deselectRowAtIndexPath:indexPath animated:self];
     RSRoleModel * rolemodel = self.dataSource[indexPath.row];
    self.title = rolemodel.name;
    [self dismiss];
    if ([self.delegate respondsToSelector:@selector(optionView:selectedIndex:)]) {
        [self.delegate optionView:self selectedIndex:indexPath.row];
    }
    if (self.selectedBlock) {
        self.selectedBlock(self, indexPath.row);
    }
}

#pragma mark getter && setter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
       // _titleLabel.text = @"管理员";
        _titleLabel.textColor = [UIColor colorWithHexColorStr:@"#E0E0E0"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView {
    if(!_rightImageView) {
        _rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"systen-Triangle-1"]];
        _rightImageView.clipsToBounds = YES;
    }
    return _rightImageView;
}

- (UIButton *)maskBtn {
    if (!_maskBtn) {
        _maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskBtn.backgroundColor = [UIColor clearColor];
        _maskBtn.clipsToBounds = YES;
        [_maskBtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
       // _tableView.tableFooterView = [[UIView new]initWithFrame:CGRectMake(0, 0, SCW, 20)];
        _tableView.rowHeight = rowheight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHexColorStr:@"#00D19C"];
        //_tableView.layer.shadowOffset = CGSizeMake(4, 4);
       // _tableView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
       // _tableView.layer.shadowOpacity = 0.8;
       // _tableView.layer.shadowRadius = 4;
       // _tableView.layer.borderColor = [UIColor grayColor].CGColor;
       // _tableView.layer.borderWidth = 0.5;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
      // [_tableView.setSeparatorColor:[UIColor clearColor]];
        //_tableView.separatorColor = [UIColor colorWithHexColorStr:@"#D8D8D8"];
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        }
    }
    return _tableView;
}

- (UIView *)headerview{
    
    if (!_headerview) {
        _headerview = [[UIView alloc]init];
        _headerview.backgroundColor = [UIColor clearColor];
    }
    return _headerview;
}

- (UIImageView *)headerImage{
    if (!_headerImage) {
        _headerImage = [[UIImageView alloc]init];
        _headerImage.backgroundColor = [UIColor clearColor];
        _headerImage.image = [UIImage imageNamed:@"systen-T"];
    }
    return _headerImage;
    
}



- (UIButton *)backgroundBtn {
    if (!_backgroundBtn) {
        _backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundBtn.backgroundColor = [UIColor clearColor];
        _backgroundBtn.frame = [UIScreen mainScreen].bounds;
        [_backgroundBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundBtn;
}

- (void)setRowHeigt:(CGFloat)rowHeigt {
    _rowHeigt = rowHeigt;
    self.tableView.rowHeight = rowHeigt;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    if (self.rowHeigt) {
        self.tableViewHeight = self.dataSource.count*self.rowHeigt;
    }else {
        self.tableViewHeight = self.dataSource.count*rowheight;
    }
}

- (void)setTitleFontSize:(CGFloat)titleFontSize {
    _titleFontSize = titleFontSize;
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return (UIColor *)self.layer.borderColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

@end
