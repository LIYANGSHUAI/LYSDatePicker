//
//  LYSDateContentView.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateContentView.h"

@implementation LYSDateContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), 0);
    }
    return self;
}

- (void)refreshContentHeight
{
    CGFloat height = 0;
    for (UIView *view in self.subviews) {
        height += CGRectGetHeight(view.frame);
    }
    CGRect contentFrame = self.frame;
    contentFrame.size.height = height;
    self.frame = contentFrame;
}

// 禁止事件向下传递
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
