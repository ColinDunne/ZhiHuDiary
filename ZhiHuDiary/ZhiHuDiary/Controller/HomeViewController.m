//
//  HomeViewController.m
//  ZhiHuDiary
//
//  Created by 钱辰 on 4/9/15.
//  Copyright (c) 2015 qianchen. All rights reserved.
//

#import "HomeViewController.h"
#import "Article.h"

@interface HomeViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *headerView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UITableView *articleTableView;
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
    
    self.articleTableView.frame = CGRectMake(0, kIMAGEHEIGHT, kIMAGEWIDTH, kTABLEHEIGHT);
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

#pragma mark - UITableViewDelegate

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
    }
    
    return _articleTableView;
}

@end
