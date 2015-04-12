//
//  DataManager.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "DataManager.h"
#import "Article.h"

@implementation DataManager

- (instancetype)initWithFile:(NSString *)fileName {
    if (self = [super init]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
        
        NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:[array count]];
        for (NSDictionary *dict in array) {
            [mutableArray addObject:[Article articleWithDict:dict]];
        }
        
        self.dataArray = [mutableArray copy];
    }
    
    return self;
}

+ (instancetype)dataManagerWithFile:(NSString *)fileName {
    return [[DataManager alloc] initWithFile:fileName];
}

+ (NSArray *)cateArray {
    return @[@"首页",@"日常心理学",@"用户推荐日报",@"电影日报",@"不许无聊",@"设计日报",@"大公司日报",@"财经日报",@"互联网安全",@"开始游戏",@"音乐日报",@"体育日报",@"动漫日报"];
}

- (NSArray *)sortedDataArray {
    if (!self.dataArray) {
        return nil;
    }
    
    // 倒序排列，新的文章放在前面
    self.dataArray = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(Article *obj1, Article *obj2) {
        if ([obj1.date compare:obj2.date]) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    // 按照section对数据分组
    NSString *key = nil;
    NSMutableArray *valueArray = nil;
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    for (Article *article in self.dataArray) {
        key = article.section;
        valueArray = dataDict[key];
        
        if (valueArray == nil) {
            valueArray = [NSMutableArray arrayWithArray:@[article]];
            [dataDict setValue:valueArray forKey:key];
        } else {
            [valueArray addObject:article];
            [dataDict setValue:valueArray forKey:key];
        }
    }
    
    // 由NSDictionary转成NSArray
    NSArray *unsortedArray = nil;
    NSArray *sortedArray = nil;
    NSMutableArray *sortedDataArray = [[NSMutableArray alloc] init];
    for (NSString *key in dataDict.keyEnumerator) {
        valueArray = dataDict[key];
        // 对value中的数组进行排序
        unsortedArray = [valueArray copy];
        sortedArray = [unsortedArray sortedArrayUsingComparator:^NSComparisonResult(Article *obj1, Article *obj2) {
            if ([obj1.date compare:obj2.date]) {
                return NSOrderedDescending;
            } else {
                return NSOrderedAscending;
            }
        }];
        
        [sortedDataArray addObject:sortedArray];
    }
    
    return [sortedDataArray copy];
}

@end
