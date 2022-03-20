//
//  HQPickerView.h
//  HQPickerView
//
//  Created by admin on 2017/8/29.
//  Copyright © 2017年 judian. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol HQPickerViewDelegate <NSObject>
//- (void)pickerView:(UIPickerView *)pickerView didSelectText:(NSString *)text;
//@end


typedef void(^PickBlock)(UIPickerView * pickerView,NSString * text);
@interface HQPickerView : UIView

@property (nonatomic, strong) NSMutableArray * customArr;

@property (nonatomic, strong)PickBlock pickBlock;

//@property (nonatomic, weak) id <HQPickerViewDelegate> delegate;

@end
