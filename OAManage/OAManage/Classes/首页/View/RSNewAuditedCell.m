//
//  RSNewAuditedCell.m
//  OAManage
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNewAuditedCell.h"

@interface RSNewAuditedCell()

@property (nonatomic,strong)UIButton * timeBtn;

@property (nonatomic,strong)UILabel * timeLabel;

@end


@implementation RSNewAuditedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        //图片
        UIButton * timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [timeBtn setBackgroundImage:[UIImage imageNamed:@"编组复制"] forState:UIControlStateNormal];
        [timeBtn setTitle:@"周一" forState:UIControlStateNormal];
        [timeBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        timeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:timeBtn];
        _timeBtn = timeBtn;
        
        
        //时间
        UILabel * timeLabel = [[UILabel alloc]init];
        timeLabel.text = @"2020-01-07";
        timeLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        timeLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:timeLabel];
        _timeLabel = timeLabel;
        
        //删除
        UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setTitleColor:[UIColor colorWithHexColorStr:@"#27C79A"] forState:UIControlStateNormal];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        
        //编辑
        UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#27C79A"]];
        [editBtn setTitleColor:[UIColor colorWithHexColorStr:@"#FFFFFF"] forState:UIControlStateNormal];
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:editBtn];
        _editBtn = editBtn;
        //下划线
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#F2F2F2"];
        [self.contentView addSubview:bottomview];
        
        timeBtn.frame = CGRectMake(15, 54/2 - 12, 25, 24);

//        timeBtn.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(self.contentView, 15)
//        .widthIs(25)
//        .heightIs(24);
        
        timeBtn.titleLabel.sd_layout
        .topSpaceToView(timeBtn, 10);
        
        
        
//        timeLabel.sd_layout
//        .centerYEqualToView(self.contentView)
//        .leftSpaceToView(timeBtn, 8)
//        .topEqualToView(timeBtn)
//        .bottomEqualToView(timeBtn)
//        .widthRatioToView(self.contentView, 0.4);
        
        timeLabel.frame = CGRectMake(CGRectGetMaxX(timeBtn.frame) + 8, 54/2 - 12, self.contentView.yj_width * 0.4, 24);
        
        
//        editBtn.sd_layout
//        .centerYEqualToView(self.contentView)
//        .rightSpaceToView(self.contentView, 15)
//        .widthIs(44)
//        .heightIs(18);
        
        
        editBtn.frame = CGRectMake(SCW - 44 - 15, 54/2 - 9, 44, 18);
        
        editBtn.layer.cornerRadius = 9;
        editBtn.layer.masksToBounds = YES;
        
        
//        deleteBtn.sd_layout
//        .centerYEqualToView(self.contentView)
//        .rightSpaceToView(editBtn, 8)
//        .topEqualToView(editBtn)
//        .bottomEqualToView(editBtn)
//        .widthIs(44);
        
        deleteBtn.frame = CGRectMake(SCW - 44 - 15 - 44 - 8, 54/2 - 9,44, 18);
        
        
//        bottomview.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(0.5);
        
        bottomview.frame = CGRectMake(0, 53.5, SCW, 0.5);
        
    }
    return self;
}

- (void)setAuditedmodel:(RSNewAuditedModel *)auditedmodel{
    _auditedmodel = auditedmodel;
    _timeLabel.text = [_auditedmodel.diaryDate substringToIndex:10];
    [_timeBtn setTitle:[self weekDayStr:_timeLabel.text] forState:UIControlStateNormal];
}






//根据时间来获取星期几
- (NSString*)weekDayStr:(NSString*)format{
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(format.length>=10) {
        NSString *nowString = [format substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if(array.count==0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if(array.count>=3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取传入date
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    switch(week) {
        case 1:
            weekDayStr =@"周日";
            break;
        case 2:
            weekDayStr =@"周一";
            break;
        case 3:
            weekDayStr =@"周二";
            break;
        case 4:
            weekDayStr =@"周三";
            break;
        case 5:
            weekDayStr =@"周四";
            break;
        case 6:
            weekDayStr =@"周五";
            break;
        case 7:
            weekDayStr =@"周六";
            break;
        default:
            weekDayStr =@"";
            break;
    }
    return weekDayStr;
}



@end
