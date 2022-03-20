
#import "SCNavigationMenuTitleCell.h"

@interface SCNavigationMenuTitleCell ()

//@property (nonatomic, strong) CALayer *lineLayer;
@property (nonatomic, strong) UILabel * titleLabel;


@property (nonatomic, strong) UIImageView * titleImage;

@end

@implementation SCNavigationMenuTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithRed:106/255.0 green:122/255.0 blue:145/255.0 alpha:1];
        //[self.contentView.layer addSublayer:self.lineLayer];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.titleImage];
//        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
//        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
//        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0];
//        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
//        [self.contentView addConstraints:@[top, left, right, bottom]];
    }
    return self;
}

+ (NSNumber *)cellHeightWithNavigationMenuItem:(id<SCNavigationMenuItemProtocol>)navigationMenuItem
{
    return @(43);
}

+ (NSString *)reuseID
{
    return NSStringFromClass(self);
}

- (void)configCellWithNavigationMenuItem:(id<SCNavigationMenuItemProtocol>)navigationMenuItem selected:(BOOL)selected
{
    NSString *title;
    UIColor *color;
    BOOL isShowImage;
    if (selected) {
        NSString *selectedTitle;
        if ([navigationMenuItem respondsToSelector:@selector(menuSelectedTitle)]) {
            selectedTitle = [navigationMenuItem menuSelectedTitle];
        }
        title = selectedTitle.length > 0 ? selectedTitle : [navigationMenuItem menuTitle];
        color = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        isShowImage = true;
    } else {
        title = [navigationMenuItem menuTitle];
        color = [UIColor colorWithRed:160/255.0 green:171/255.0 blue:187/255.0 alpha:1];
        isShowImage = false;
    }
    self.titleLabel.text = title ?: @"";
    self.titleImage.hidden = !isShowImage;
    self.titleLabel.textColor = color;
}

//- (CALayer *)lineLayer
//{
//    if (!_lineLayer) {
//        _lineLayer = [CALayer layer];
//        _lineLayer.backgroundColor = [UIColor grayColor].CGColor;
//        CGFloat height = 1 / UIScreen.mainScreen.scale;
//        _lineLayer.frame = CGRectMake(45, 0, UIScreen.mainScreen.bounds.size.width - 90, height);
//    }
//    return _lineLayer;
//}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.frame = CGRectMake(18, 6.5, UIScreen.mainScreen.bounds.size.width - 40 - 12, 30);
        //_titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _titleLabel;
}


- (UIImageView *)titleImage{
    if (!_titleImage) {
        _titleImage = [[UIImageView alloc]init];
        _titleImage.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 10,15.5,16,12);
        _titleImage.image = [UIImage imageNamed:@"打勾"];
       // _titleImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleImage;
    
    
}


@end
