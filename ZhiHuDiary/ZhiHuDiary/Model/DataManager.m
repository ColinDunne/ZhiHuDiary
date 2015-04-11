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

- (NSArray *)sortedDataArray {
    if (!self.dataArray) {
        return nil;
    }
    
    // 排序
    NSArray *sortedArray = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(Article *obj1, Article *obj2) {
        if ([obj1.date compare:obj2.date]) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
    }];
    
    // 按照section对数据分组
    NSString *key = nil;
    NSMutableArray *valueArray = nil;
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
    for (Article *article in sortedArray) {
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
    NSMutableArray *sortedDataArray = [[NSMutableArray alloc] init];
    for (NSString *key in dataDict.keyEnumerator) {
        valueArray = dataDict[key];
        [sortedDataArray addObject:[valueArray copy]];
    }
    
    return [sortedDataArray copy];
}

@end
