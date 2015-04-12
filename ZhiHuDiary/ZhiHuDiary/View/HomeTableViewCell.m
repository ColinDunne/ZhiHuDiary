//
//  HomeTableViewCell.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

+ (instancetype)cellFromNib {
    return [[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:nil options:nil][2];
}

+ (NSString *)Identifier {
    return @"articleCell";
}

+ (CGFloat)CellHeight {
    return 80;
}

- (void)updateDataWithArticle:(Article *)article {
    self.titleLabel.text = article.name;
    self.cateLabel.text = article.cate;
    self.thumbnailView.image = [UIImage imageNamed:article.icon];
}

@end
