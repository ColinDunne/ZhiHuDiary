//
//  HomeHeaderView.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "HomeHeaderView.h"

#define kTABLEWIDTH 375

@implementation HomeHeaderView

+(instancetype)headerViewWithTableView:(UITableView *)tableView {
    HomeHeaderView *header = [tableView dequeueReusableCellWithIdentifier:[HomeHeaderView Identifier]];
    if (!header) {
        header = [[HomeHeaderView alloc] initWithReuseIdentifier:[HomeHeaderView Identifier]];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)identifier {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kTABLEWIDTH, [HomeHeaderView SectionHeight]);
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, kTABLEWIDTH, [HomeHeaderView SectionHeight]);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor colorWithRed:56.0/256 green:159.0/256 blue:219.0/256 alpha:1];
        
        [self addSubview:titleLabel];
    }
    
    return self;
}

+ (NSString *)Identifier {
    return @"header";
}

+ (CGFloat)SectionHeight {
    return 30;
}

- (void)setTitle:(NSString *)title {
    UILabel *titleLabel = [self subviews][0];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor whiteColor];
}

@end
