//
//  LYSDatePickerViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerViewController.h"
#import <objc/runtime.h>

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface LYSDatePickerViewController ()

// 选择器视图
@property (nonatomic,strong,readwrite)UIPickerView *pickView;

@end

@implementation LYSDatePickerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认选择器高度
        self.pickViewHeight = 220;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 初始化选择器
    [self initPickerView];
}

- (UIPickerView *)pickView
{
    if (!_pickView) {
        CGFloat headerViewHeight = 0;
        id tag = objc_getAssociatedObject(self.headerView, @"tag");
        if (tag && [tag boolValue]) {
            headerViewHeight = self.pickHeaderHeight;
        }else {
            headerViewHeight = CGRectGetHeight(self.headerView.frame);
        }
        if (self.showIndicator) {
            headerViewHeight += self.indicatorHeight;
        }
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, headerViewHeight, ScreenWidth, self.pickViewHeight)];
    }
    return _pickView;
}

// 初始化选择器
- (void)initPickerView
{
    [self.contentView addSubview:self.pickView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
