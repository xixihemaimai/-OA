//
//  RSNameOfCargoCell.m
//  OAManage
//
//  Created by mac on 2019/12/23.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSNameOfCargoCell.h"

@interface RSNameOfCargoCell()


@property (nonatomic,strong)UILabel * nameLabel;
@end

@implementation RSNameOfCargoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        
        UILabel * nameLabel = [[UILabel alloc]init];
        nameLabel.text = @"喵小黑";
        nameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:nameLabel];
        
        nameLabel.frame = CGRectMake(12, 0, SCW * 0.5, 42);
        
        
//        nameLabel.sd_layout
//        .leftSpaceToView(self.contentView, 12)
//        .rightSpaceToView(self.contentView, 12)
//        .topSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0.5);
        
        _nameLabel = nameLabel;
        UIView * bottomview = [[UIView alloc]init];
        bottomview.backgroundColor = [UIColor colorWithHexColorStr:@"#f0f0f0"];
        [self.contentView addSubview:bottomview];
        
//        bottomview.sd_layout
//        .leftSpaceToView(self.contentView, 0)
//        .rightSpaceToView(self.contentView, 0)
//        .bottomSpaceToView(self.contentView, 0)
//        .heightIs(0.5);
        
        
        bottomview.frame = CGRectMake(0, 41.5, SCW, 0.5);
    }
    return self;
}


- (void)setShippermodel:(RSShipperMode *)shippermodel{
    _shippermodel = shippermodel;
    _nameLabel.text = _shippermodel.name;
}

- (void)setWarehousemodel:(RSWarehouseModel *)warehousemodel{
    _warehousemodel = warehousemodel;
    _nameLabel.text = _warehousemodel.name;
    
}

- (void)setStoreAreamodel:(RSStoreAreaModel *)storeAreamodel{
    _storeAreamodel = storeAreamodel;
    _nameLabel.text = _storeAreamodel.name;
}

- (void)setFeemodel:(RSFeeModel *)feemodel{
    _feemodel = feemodel;
    _nameLabel.text = _feemodel.name;
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
