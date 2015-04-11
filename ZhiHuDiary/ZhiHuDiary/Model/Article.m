//
//  Article.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "Article.h"

@implementation Article

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[@"name"];
        self.icon = dict[@"icon"];
        self.cate = dict[@"cate"];
        self.date = dict[@"date"];
        self.section = dict[@"section"];
        self.url = dict[@"url"];
    }
    
    return self;
}

+ (instancetype)articleWithDict:(NSDictionary *)dict {
    return [[Article alloc] initWithDict:dict];
}

@end
