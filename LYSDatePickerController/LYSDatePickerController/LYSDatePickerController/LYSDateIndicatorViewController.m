//
//  LYSDateIndicatorViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateIndicatorViewController.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface LYSDateIndicatorViewController ()

@end

@implementation LYSDateIndicatorViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认显示分割线
        self.showIndicator = YES;
        // 分割线默认颜色
        self.indicatorColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        // 分割线高度
        self.indicatorHeight = 5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置分割线
    [self initIndicator];
}

// 初始化分割线
- (void)initIndicator
{
    if (self.showIndicator) {
        CGFloat headerViewHeight = CGRectGetHeight(self.headerView.frame);
        UIImage *line = [self imageWithColor:self.indicatorColor alpha:1];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:line];
        lineView.frame = Rect(0, headerViewHeight, ScreenWidth, self.indicatorHeight);
        [self.contentView addSubview:lineView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
