//
//  HomeViewController.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/9/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "HomeViewController.h"
#import "DataManager.h"
#import "Article.h"
#import "HomeHeaderView.h"
#import "HomeTableViewCell.h"

@interface HomeViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UITableView *articleTableView;
@property (nonatomic, strong) NSArray *articles;
@end

@implementation HomeViewController

#define kIMAGEWIDTH 375
#define kIMAGEHEIGHT 180
#define kTABLEHEIGHT 487
#define kIMAGECOUNT 6

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.articleTableView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / kIMAGEWIDTH;
    self.pageControl.currentPage = page;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.articles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeTableViewCell Identifier]];
    if (!cell) {
        cell = [HomeTableViewCell cellFromNib];
    }
    
    [cell updateDataWithArticle:self.articles[indexPath.section][indexPath.row]];

    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeHeaderView *headerView = [HomeHeaderView headerViewWithTableView:tableView];
    
    Article *article = self.articles[section][0];
    headerView.title = article.section;
    
    return headerView;
}

#pragma mark - Getter & Setter

- (UIScrollView *)headerView {
    if (!_headerView) {
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:self options:nil][0];
        // 设置代理
        _headerView.delegate = self;
        
        // 设置位置大小
        _headerView.frame = CGRectMake(0, 0, kIMAGEWIDTH, kIMAGEHEIGHT);
        
        // 排列图片
        for (int i = 0; i < kIMAGECOUNT; i++) {
            NSString *imageName = [NSString stringWithFormat:@"0%d", i];
            UIImage *image = [UIImage imageNamed:imageName];
            CGFloat x = i * kIMAGEWIDTH;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, kIMAGEWIDTH, kIMAGEHEIGHT)];
            imageView.image = image;
            [_headerView addSubview:imageView];
        }
        
        // 设置滚动范围
        _headerView.contentSize = CGSizeMake(kIMAGECOUNT * kIMAGEWIDTH, 0);
        
        // 滚动条不可见
        _headerView.showsHorizontalScrollIndicator = NO;
        _headerView.showsVerticalScrollIndicator = NO;
        
        // 边界不回弹
        _headerView.bounces = NO;
        
        // 支持分页
        _headerView.pagingEnabled = YES;
    }
    
    return _headerView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.center = CGPointMake(kIMAGEWIDTH * 0.5, kIMAGEHEIGHT - 20);
        _pageControl.numberOfPages = kIMAGECOUNT;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    
    return _pageControl;
}

- (UITableView *)articleTableView {
    if (!_articleTableView) {
        _articleTableView = [[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:self options:nil][1];
        _articleTableView.dataSource = self;
        _articleTableView.delegate = self;
        
        _articleTableView.frame = CGRectMake(0, kIMAGEHEIGHT, kIMAGEWIDTH, kTABLEHEIGHT);
        
        _articleTableView.sectionHeaderHeight = 30;
        
        _articleTableView.rowHeight = [HomeTableViewCell CellHeight];
        
    }
    
    return _articleTableView;
}

- (NSArray *)articles {
    if (!_articles) {
        DataManager *dataManager = [DataManager dataManagerWithFile:@"Article"];
        _articles = [dataManager sortedDataArray];
    }
    
    return _articles;
}

@end
