//
//  LYSDateIndicatorViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateIndicatorViewController.h"

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
        self.indicatorColor = [UIColor lightGrayColor];
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
        UIImage *line = [self ly_imageWithColor:self.indicatorColor alpha:1];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:line];
        lineView.frame = CGRectMake(0, headerViewHeight, CGRectGetWidth(self.view.frame), 0.5);
        [self.contentView addSubview:lineView];
    }
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
