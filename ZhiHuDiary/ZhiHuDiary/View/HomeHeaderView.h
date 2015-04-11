//
//  HomeHeaderView.h
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UIView

@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
