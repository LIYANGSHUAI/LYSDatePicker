//
//  LYSDatePickerViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerViewController.h"
#import <objc/runtime.h>

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
        self.pickViewHeight = 250;
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
            headerViewHeight += 0.5;
        }
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, headerViewHeight, CGRectGetWidth(self.view.frame), self.pickViewHeight)];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
