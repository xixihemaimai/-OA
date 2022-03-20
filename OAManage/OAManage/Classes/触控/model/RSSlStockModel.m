//
//  RSSlStockModel.m
//  OAManage
//
//  Created by mac on 2019/12/26.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSSlStockModel.h"

@implementation RSSlStockModel

- (NSMutableArray *)piece{
    if (!_piece) {
        _piece = [NSMutableArray array];
    }
    return _piece;
}


@end
