//
//  HomeTableViewCell.h
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

+ (instancetype)cellFromNib;

+ (NSString *)Identifier;

+ (CGFloat)CellHeight;

- (void)updateDataWithArticle:(Article *)article;

@end
