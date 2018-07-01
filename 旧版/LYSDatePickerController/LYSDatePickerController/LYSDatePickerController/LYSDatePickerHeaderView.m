//
//  LYSDatePickerHeaderView.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerHeaderView.h"
#import "LYSDateHeaderViewController.h"

@implementation LYSDatePickerHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showTimeLabel = YES;
        self.titleDateFormat = @"yyyy-MM-dd HH:mm:ss";
        [self customSubViews];
    }
    return self;
}

- (LYSDatePickerItem *)leftItem
{
    if (!_leftItem) {
        _leftItem = [LYSDatePickerItem btnWithTitle:@"取消" target:self action:@selector(cancelAction:)];
    }
    return _leftItem;
}

- (LYSDatePickerItem *)rightItem
{
    if (!_rightItem) {
        _rightItem = [LYSDatePickerItem btnWithTitle:@"确定" target:self action:@selector(commitAction:)];
    }
    return _rightItem;
}

- (LYSDatePickerItem *)centerItem
{
    if (!_centerItem) {
        _centerItem = [LYSDatePickerItem labelWithTitle:@"日期选择器"];
    }
    return _centerItem;
}

- (LYSDatePickerItem *)tileLabelItem
{
    if (!_tileLabelItem) {
        _tileLabelItem = [LYSDatePickerItem labelWithTitle:@""];
    }
    return _tileLabelItem;
}

- (void)cancelAction:(LYSDatePickerItem *)sender {
    [self.headerVC cancelDatePicker];
    [self.headerVC hiddenDatePicker];
}

- (void)commitAction:(LYSDatePickerItem *)sender {
    [self.headerVC commitDatePicker];
    [self.headerVC hiddenDatePicker];
}

- (void)customSubViews {
    [self addSubview:self.leftItem.itemView];
    [self addSubview:self.rightItem.itemView];
    if (self.showTimeLabel) {
        [self addSubview:self.tileLabelItem.itemView];
    } else {
        [self addSubview:self.centerItem.itemView];
    }
}

- (void)setShowTimeLabel:(BOOL)showTimeLabel
{
    _showTimeLabel = showTimeLabel;
    if (_showTimeLabel) {
        [self.centerItem.itemView removeFromSuperview];
        [self addSubview:self.tileLabelItem.itemView];
    } else {
        [self.tileLabelItem.itemView removeFromSuperview];
        [self addSubview:self.centerItem.itemView];
    }
}

- (void)setHeaderHeight:(CGFloat)headerHeight
{
    _headerHeight = headerHeight;
    
    [self.leftItem updateSize];
    
    CGRect leftItemFrame = self.leftItem.itemView.frame;
    leftItemFrame.origin.x = 5;
    leftItemFrame.origin.y = (_headerHeight - CGRectGetHeight(leftItemFrame))/2.0;
    self.leftItem.itemView.frame = leftItemFrame;
    
    [self.rightItem updateSize];
    
    CGRect rightItemFrame = self.rightItem.itemView.frame;
    rightItemFrame.origin.x = [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(rightItemFrame) - 5;
    rightItemFrame.origin.y = (_headerHeight - CGRectGetHeight(rightItemFrame))/2.0;
    self.rightItem.itemView.frame = rightItemFrame;
    
    if (self.showTimeLabel) {
        [self.tileLabelItem updateSize];
        CGRect titleLabelItemFrame = self.tileLabelItem.itemView.frame;
        titleLabelItemFrame.origin.x = ([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(titleLabelItemFrame))/2.0;
        titleLabelItemFrame.origin.y = (_headerHeight - CGRectGetHeight(titleLabelItemFrame))/2.0;
        self.tileLabelItem.itemView.frame = titleLabelItemFrame;
    } else {
        [self.centerItem updateSize];
        CGRect centerItemFrame = self.centerItem.itemView.frame;
        centerItemFrame.origin.x = ([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(centerItemFrame))/2.0;
        centerItemFrame.origin.y = (_headerHeight - CGRectGetHeight(centerItemFrame))/2.0;
        self.centerItem.itemView.frame = centerItemFrame;
    }

}

- (void)updateDate:(NSDate *)date {
    if (self.showTimeLabel) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:self.titleDateFormat];
        self.tileLabelItem.title = [dateFormat stringFromDate:date];
        [self.tileLabelItem updateSize];
        CGRect titleLabelItemFrame = self.tileLabelItem.itemView.frame;
        titleLabelItemFrame.origin.x = ([UIScreen mainScreen].bounds.size.width - CGRectGetWidth(titleLabelItemFrame))/2.0;
        titleLabelItemFrame.origin.y = (_headerHeight - CGRectGetHeight(titleLabelItemFrame))/2.0;
        self.tileLabelItem.itemView.frame = titleLabelItemFrame;
    }
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    return [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil].size;
}

@end
