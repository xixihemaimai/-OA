//
//  BCContentOB.m
//  xxxxxxxx
//
//  Created by WF on 2017/2/20.
//  Copyright © 2017年 WF. All rights reserved.
//

#import "BCContentOB.h"

@implementation BCContentOB
-(NSArray *)getAttributeNameArray{
    return @[@"序号",@"结算对象",@"上期总应收",@"本期应收",@"第四属性",@"第五属性",@"第六属性",@"第七属性",@"第八属性"];
}
-(NSArray *)getAttributeArray{
    return @[@"name",@"attributeFirst",@"attributeSecond",@"attributeThird",@"attributeFourth",@"attributeFifth",@"attributeSixth",@"attributeSeventh",@"attributeEighth"];
}
-(NSDictionary *)getDicOfOB{
    return @{@"name":_name,@"attributeFirst":_attributeFirst,@"attributeSecond":_attributeSecond,@"attributeThird":_attributeThird,@"attributeFourth":_attributeFourth,@"attributeFifth":_attributeFifth,@"attributeSixth":_attributeSixth,@"attributeSeventh":_attributeSeventh,@"attributeEighth":_attributeEighth};
}
@end
