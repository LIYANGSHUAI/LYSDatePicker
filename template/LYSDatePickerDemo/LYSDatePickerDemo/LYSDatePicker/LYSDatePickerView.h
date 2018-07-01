//
//  LYSDatePickerView.h
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSDateHeaderViewProtocol.h"

typedef NS_ENUM(NSUInteger, LYSDatePickerType) {
    LYSDatePickerTypeCustom,   // Date component is selected UIPickerView
    LYSDatePickerTypeSystem    // Date component is selected UIDatePicker
};

@interface LYSDatePickerView : UIView

/// Whether to show the top status bar, the default is YES
@property(nonatomic, assign) BOOL enableShowHeader;

@property(nonatomic, strong) UIView<LYSDateHeaderViewProtocol> *headerView;

@property(nonatomic, assign) CGFloat headerHeight;

@property(nonatomic, assign, readonly) LYSDatePickerType type;
- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type;
@end
