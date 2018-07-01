//
//  LYSDatePickerView.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerView.h"
#import "LYSDateHeadrView.h"

#define ContainerWidth      CGRectGetWidth(self.frame)
#define ContainerHeight     CGRectGetHeight(self.frame)
#define HeaderViewFrame     CGRectMake(0, 0, ContainerWidth, self.headerHeight)
#define PickerViewFrame     CGRectMake(0, self.headerHeight, ContainerWidth, ContainerHeight - self.headerHeight)

@interface LYSDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic, assign, readwrite) LYSDatePickerType type;
@property(nonatomic, strong) UIPickerView *pickerView;
@end

@implementation LYSDatePickerView

- (UIView<LYSDateHeaderViewProtocol> *)headerView
{
    if (!_headerView) {
        _headerView = [[LYSDateHeadrView alloc] initWithFrame:HeaderViewFrame];
    }
    return _headerView;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:PickerViewFrame];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)didMoveToSuperview
{
    [self clearSubViews];
    [self defaultParms];
    [self additionSubViews];
}
/// 设置默认值
- (void)defaultParms
{
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    self.enableShowHeader = YES;
    self.headerHeight = 40;
}
/// 添加子视图
- (void)additionSubViews
{
    if (self.enableShowHeader) {
        [self addSubview:self.headerView];
    }
    [self addSubview:self.pickerView];
}
/// 清除子视图
- (void)clearSubViews
{
    if (_headerView) {
        [_headerView removeFromSuperview];
        _headerView = nil;
    }
    if (_pickerView) {
        [_pickerView removeFromSuperview];
        _pickerView = nil;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
    }
    label.text = @"11";
    label.backgroundColor = [UIColor redColor];
    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"33";
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}


@end
