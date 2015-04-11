//
//  HomeHeaderView.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"header";
    HomeHeaderView *header = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!header) {
        header = [[HomeHeaderView alloc] initWithReuseIdentifier:identifier];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 375, 30);
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, 375, 30);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor blueColor];
        
        [self addSubview:titleLabel];
    }
    
    return self;
}

- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [self subviews][0];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
}

@end
