//
//  LYSDatePickerHeaderView.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSDatePickerItem.h"

@class LYSDateHeaderViewController;

// 如果要自定义头视图,并且要实时获取选择时间,可以让自定义视图遵循这个代理方法即可
@protocol LYSDatePickerHeaderViewProtocol <NSObject>

- (void)updateDate:(NSDate *)date;

@end

@interface LYSDatePickerHeaderView : UIView<LYSDatePickerHeaderViewProtocol>

@property(nonatomic, weak)LYSDateHeaderViewController *headerVC;

// 头视图左侧按钮,可以自定义
@property(nonatomic, strong)LYSDatePickerItem *leftItem;
// 头视图右侧按钮,可以自定义
@property(nonatomic, strong)LYSDatePickerItem *rightItem;
// 头视图中间按钮,可以自定义
@property(nonatomic, strong)LYSDatePickerItem *centerItem;

// 默认是NO,即不实时显示选择时间
@property(nonatomic, assign)BOOL showTimeLabel;
// 当showTimeLabel为YES时,默认使用这个属性作为中间按钮
@property(nonatomic, strong)LYSDatePickerItem *tileLabelItem;
// 当实时监控选择时间时,默认显示的时间格式
@property(nonatomic, copy)NSString *titleDateFormat;

@property(nonatomic, assign)CGFloat headerHeight;

@end
