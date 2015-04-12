//
//  DataManager.h
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/11/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

@property (nonatomic, strong) NSArray *dataArray;

- (instancetype)initWithFile:(NSString *)fileName;

+ (instancetype)dataManagerWithFile:(NSString *)fileName;

- (NSArray *)sortedDataArray;

+ (NSArray *)cateArray;

@end
