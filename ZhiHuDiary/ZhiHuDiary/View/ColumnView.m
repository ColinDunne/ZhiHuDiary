//
//  ColumnView.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/12/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "ColumnView.h"

@implementation ColumnView

+ (instancetype)columnViewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:nil options:nil][3];
}

@end
