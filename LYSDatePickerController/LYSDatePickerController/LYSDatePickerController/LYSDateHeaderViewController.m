//
//  LYSDateHeaderViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateHeaderViewController.h"
#import <objc/runtime.h>

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface LYSDateHeaderViewController ()

@end

@implementation LYSDateHeaderViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pickHeaderHeight = 40;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化头视图
    [self initHeaderView];
}

- (LYSDatePickerHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[LYSDatePickerHeaderView alloc] init];
        objc_setAssociatedObject(_headerView, @"tag", @(YES), OBJC_ASSOCIATION_ASSIGN);
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

// 初始化头视图
- (void)initHeaderView
{
    id tag = objc_getAssociatedObject(self.headerView, @"tag");
    if (tag && [tag boolValue]) {
        CGFloat headerViewHeight = self.pickHeaderHeight;
        self.headerView.frame = Rect(0, 0, ScreenWidth, headerViewHeight);
        self.headerView.headerHeight = headerViewHeight;
        self.headerView.headerVC = self;
        [self.contentView addSubview:self.headerView];
    } else {
        CGRect headerFrame = self.headerView.frame;
        headerFrame.origin = CGPointZero;
        headerFrame.size.width = ScreenWidth;
        self.headerView.frame = headerFrame;
        [self.contentView addSubview:self.headerView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
