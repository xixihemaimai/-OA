//
//  MyTableListView.m
//  xxxxxxxx
//
//  Created by WF on 2017/1/14.
//  Copyright © 2017年 WF. All rights reserved.
//
#define FIRSTCELLWIDTH 70 //第一个cell的宽度

#define OTHERCELLWIDTH 120  //其他cell的宽度

#define ALLCELLHIGH 34  //所有cell的高度

#import "MyTableListView.h"
#import "BCMyCollectionViewCell.h"
#import "BCMyTableViewCell.h"
#import "RSFeeNameCell.h"
@interface MyTableListView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UICollectionViewFlowLayout*customLayout;



@property(strong,nonatomic)UIScrollView * scrollView;




@property(strong,nonatomic)NSArray * arrayAttributeName;//属性名字
@property(strong,nonatomic)NSArray * arrayAttribute;//属性




@property (nonatomic,assign)NSInteger marketpee;

@end
@implementation MyTableListView
- (NSMutableArray *)arrayContent{
    if (!_arrayContent) {
        _arrayContent = [NSMutableArray array];
    }
    return _arrayContent;
}

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";




-(void)addColumnarContentArray:(NSMutableArray *)array{
    [self.arrayContent addObjectsFromArray:array];
    [_table reloadData];
    [_rightTable reloadData];
    [_collectionView reloadData];
}


-(instancetype)initWithFrame:(CGRect)frame andContentDicArray:(NSMutableArray *)contentDicArray andAttributeName:(NSArray *)attributeName andAttribute:(NSArray *)attribute andMarketPee:(NSInteger)marketpee{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.frame=frame;
        self.arrayContent=contentDicArray;
        self.arrayAttributeName = attributeName;
        self.arrayAttribute = attribute;
        [self creatTableListViewUI];
        self.marketpee = marketpee;
    }
    return self;
}
-(void)creatTableListViewUI{
    //整体布局 右 除了第一列以外的底层布局
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(FIRSTCELLWIDTH + 120, 0 , self.frame.size.width-FIRSTCELLWIDTH, self.frame.size.height)];
    if (OTHERCELLWIDTH*(self.arrayAttributeName.count-1)>CGRectGetWidth(_scrollView.frame)) {
        _scrollView.contentSize = CGSizeMake(OTHERCELLWIDTH*(self.arrayAttributeName.count-1) + 70, _scrollView.frame.size.height);
//        _scrollView.contentOffset = CGPointMake(-120, 0);
    }
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];

    //上层布局 左
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FIRSTCELLWIDTH, 44)];
    label.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    label.layer.borderWidth = 0.5f;
    label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    label.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.f];
    label.text = [_arrayAttributeName objectAtIndex:0];
    [self addSubview:label];
    
    //最左一列 name
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, ALLCELLHIGH + 10, FIRSTCELLWIDTH, self.frame.size.height - ALLCELLHIGH - 10) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.estimatedRowHeight = 0;
    _table.estimatedSectionFooterHeight = 0;
    _table.estimatedSectionHeaderHeight = 0;
    _table.tag = 200;
    _table.showsVerticalScrollIndicator = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_table];
    
    
    
    //上层布局 左
    UILabel * rightlabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, OTHERCELLWIDTH, 44)];
    rightlabel.layer.borderColor = [UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
    rightlabel.layer.borderWidth = 0.5f;
    rightlabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    rightlabel.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
    rightlabel.textAlignment = NSTextAlignmentCenter;
    rightlabel.font = [UIFont systemFontOfSize:15.f];
    rightlabel.text = [_arrayAttributeName objectAtIndex:1];
    [self addSubview:rightlabel];
    
    
    _rightTable = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_table.frame), ALLCELLHIGH + 10, OTHERCELLWIDTH, self.frame.size.height - ALLCELLHIGH - 10) style:UITableViewStylePlain];
    _rightTable.dataSource = self;
    _rightTable.delegate = self;
    _rightTable.estimatedRowHeight = 0;
    _rightTable.estimatedSectionFooterHeight = 0;
    _rightTable.estimatedSectionHeaderHeight = 0;
    _rightTable.tag = 300;
    _rightTable.showsVerticalScrollIndicator = NO;
    _rightTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_rightTable];
    
    
    //上层布局 右
    for (int i = 2; i<_arrayAttributeName.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake( (i - 2) * OTHERCELLWIDTH, 0, OTHERCELLWIDTH, 44);
        label.layer.borderColor =[UIColor colorWithHexColorStr:@"#E1E1E1"].CGColor;
        label.layer.borderWidth = 0.5f;
        label.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
        label.textColor = [UIColor colorWithHexColorStr:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.text = [_arrayAttributeName objectAtIndex:i];
        [_scrollView addSubview:label];
    }
    //左下布局
    _customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
    // 定义大小
    _customLayout.itemSize = CGSizeMake(OTHERCELLWIDTH, ALLCELLHIGH);
    // 设置最小行间距
    _customLayout.minimumLineSpacing = 0;
    // 设置垂直间距
    _customLayout.minimumInteritemSpacing = 0;
    // 设置滚动方向（默认垂直滚动）
    _customLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ALLCELLHIGH + 10, OTHERCELLWIDTH*(_arrayAttributeName.count - 1), self.frame.size.height-ALLCELLHIGH - 10) collectionViewLayout:_customLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    _collectionView.tag = 100;
    [_scrollView addSubview:_collectionView];
    // 注册cell、sectionHeader、sectionFooter
    [_collectionView registerClass:[BCMyCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
}
#pragma mark--scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag==100) {
        _table.contentOffset = scrollView.contentOffset;
        _rightTable.contentOffset = scrollView.contentOffset;
    }else if (scrollView.tag == 200){
        _collectionView.contentOffset = scrollView.contentOffset;
        _rightTable.contentOffset = scrollView.contentOffset;
    }else if (scrollView.tag == 300){
        _rightTable.contentOffset = scrollView.contentOffset;
        _collectionView.contentOffset = scrollView.contentOffset;
    }
}

#pragma mark ---- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _arrayContent.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrayAttributeName.count-2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BCMyCollectionViewCell *cell = (BCMyCollectionViewCell *)[_collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (self.marketpee == 1) {
        NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getParkDicOfOB];
//        if (indexPath.row == 0){
//            cell.label.text = [oneOB objectForKey:@"feeName"];
//        }else
            if (indexPath.row == 0){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyBegin"]];
        }else if (indexPath.row == 1){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyIn"]];
        }else if (indexPath.row == 2){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyOut"]];
        }else{
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyEnd"]];
        }
    }else if (self.marketpee == 2){
        NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB];
//        if (indexPath.row == 0){
//            cell.label.text = [oneOB objectForKey:@"dealerName"];
//        }else
            if (indexPath.row == 0){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyBegin"]];
        }else if (indexPath.row == 1){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyIn"]];
        }else if (indexPath.row == 2){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyOut"]];
        }else{
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"moneyEnd"]];
        }
    }else if (self.marketpee == 4){
        
        NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getParkDicOfDetailedOB];
////        if (indexPath.row == 0) {
////            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"dealerId"]];
////        }else
//        if (indexPath.row == 0){
//            cell.label.text = [oneOB objectForKey:@"dealerName"];
//        }
////        else if (indexPath.row == 2){
////            cell.label.text = [NSString stringWithFormat:@"%ld",[[oneOB objectForKey:@"feeId"] integerValue]];
////        }
//        else
            if (indexPath.row == 0){
            cell.label.text = [oneOB objectForKey:@"feeName"];
        }else if (indexPath.row == 1){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"money"]];
        }else if (indexPath.row == 2){
            cell.label.text = [oneOB objectForKey:@"month"];
        }else if (indexPath.row == 3){
            cell.label.text = [oneOB objectForKey:@"notes"];
        }
        else{
            cell.label.text = [oneOB objectForKey:@"payType"];
        }
    }else if (self.marketpee == 5){
        NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getParkDicOfReceivableOB];
//        if (indexPath.row == 0) {
//            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"dealerId"]];
//        }else
//        if (indexPath.row == 0){
//            cell.label.text = [oneOB objectForKey:@"dealerName"];
//        }
////        else if (indexPath.row == 2){
////            cell.label.text = [oneOB objectForKey:@"feeId"];
////        }
//        else
        if (indexPath.row == 0){
            cell.label.text = [oneOB objectForKey:@"feeName"];
        }else if (indexPath.row == 1){
            cell.label.text = [NSString stringWithFormat:@"%@",[oneOB objectForKey:@"money"]];
        }else if (indexPath.row == 2){
            cell.label.text = [oneOB objectForKey:@"month"];
        }
    }
    if (indexPath.section % 2 == 0) {
        cell.label.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    }else{
        cell.label.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
    }
    return cell;
}
// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil) {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        return headerView;
    }else if([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil){
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        return footerView;
    }
    return nil;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath{
}
#pragma mark ---- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
       return (CGSize){OTHERCELLWIDTH,ALLCELLHIGH};//方块大小
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);//前面2个数字是整个控件前的间隔
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){.0,.0};//后面数据为头高度
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return (CGSize){0,.0};//后面数据为低高度
}
#pragma mark ---- UICollectionViewDelegate

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(successOfCollectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate successOfCollectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}


#pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrayContent.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _table) {
        static NSString *strCell = @"cell";
        BCMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell){
            cell = [[BCMyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
         //NSDictionary * oneOB = [(BCContentOB *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB];
         //cell.label.text = [oneOB objectForKey:[_arrayAttribute objectAtIndex:0]];
        cell.label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.section + 1 ];
        if (indexPath.section % 2 == 0) {
            cell.label.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
        }else{
            cell.label.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8FA"];
        }
        if (self.marketpee == 2) {
            cell.detailedBtn.hidden = NO;
        }else{
            cell.detailedBtn.hidden = YES;
        }
        cell.detailedBtn.tag = indexPath.section;
        [cell.detailedBtn addTarget:self action:@selector(joinDetailAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (tableView == _rightTable){
        static NSString *strCell = @"secondCell";
        RSFeeNameCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
        if (!cell){
            cell = [[RSFeeNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.marketpee == 1) {
           NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getParkDicOfOB];
           cell.label.text = [oneOB objectForKey:@"feeName"];
        }else if (self.marketpee == 2){
           NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getDicOfOB];
           cell.label.text = [oneOB objectForKey:@"dealerName"];
        }else if (self.marketpee == 4){
           NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getParkDicOfDetailedOB];
           cell.label.text = [oneOB objectForKey:@"dealerName"];
        }else if (self.marketpee == 5){
            NSDictionary * oneOB = [(RSColumnarModel *)[_arrayContent objectAtIndex:indexPath.section] getParkDicOfReceivableOB];
            cell.label.text = [oneOB objectForKey:@"dealerName"];
        }
        return cell;
    }
    return nil;
}

- (void)joinDetailAction:(UIButton *)detailBtn{
//    NSLog(@"==============================%ld",(long)detailBtn.tag);
    if (self.detailBlock) {
        self.detailBlock(detailBtn.tag);
    }
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:false];
//
//}






-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ALLCELLHIGH;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
