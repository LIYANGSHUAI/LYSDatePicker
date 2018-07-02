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
    LYSDatePickerTypeCustom,            // Date component is selected UIPickerView
    LYSDatePickerTypeSystem             // Date component is selected UIDatePicker
};

typedef NS_ENUM(NSInteger, LYSDatePickerMode) {
    LYSDatePickerModeTime,              // Only show time                LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeDate,              // Show only date                LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeDateAndTime,       // Show date and time            LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeYearAndDate,       // Show year and date            LYSDatePickerTypeCustom
    LYSDatePickerModeYearAndDateAndTime // Show year and date and time   LYSDatePickerTypeCustom
};

typedef NS_ENUM(NSUInteger, LYSDatePickerStandard) {
    LYSDatePickerStandard12Hour,
    LYSDatePickerStandard24Hour,
    LYSDatePickerStandardDefault = LYSDatePickerStandard24Hour
};

@interface LYSDatePickerView : UIView

/// Whether to show the top status bar, the default is YES
@property (nonatomic, assign) BOOL enableShowHeader;

@property (nonatomic, strong) UIView<LYSDateHeaderViewProtocol> *headerView;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, assign) LYSDatePickerType type;
@property (nonatomic, assign) LYSDatePickerMode datePickerMode;

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;

@property(nonatomic, assign) LYSDatePickerStandard hourStandard;

@property (nonatomic,assign) NSInteger fromYear;
@property (nonatomic,assign) NSInteger toYear;

- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type;
@end
