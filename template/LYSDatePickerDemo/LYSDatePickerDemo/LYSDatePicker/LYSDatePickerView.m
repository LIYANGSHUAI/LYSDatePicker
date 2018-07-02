//
//  LYSDatePickerView.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerView.h"
#import "LYSDateHeadrView.h"

typedef NS_ENUM(NSInteger, LYSLayoutAttr) {
    Left            = NSLayoutAttributeLeft,
    Right           = NSLayoutAttributeRight,
    Top             = NSLayoutAttributeTop,
    Bottom          = NSLayoutAttributeBottom,
    Leading         = NSLayoutAttributeLeading,
    Trailing        = NSLayoutAttributeTrailing,
    Width           = NSLayoutAttributeWidth,
    Height          = NSLayoutAttributeHeight,
    CenterX         = NSLayoutAttributeCenterX,
    CenterY         = NSLayoutAttributeCenterY,
    NotAnAttribute  = NSLayoutAttributeNotAnAttribute
};

typedef NS_ENUM(NSInteger, LYSLayoutRelation) {
    LessThanOrEqual         = NSLayoutRelationLessThanOrEqual,
    Equal                   = NSLayoutRelationEqual,
    GreaterThanOrEqual      = NSLayoutRelationGreaterThanOrEqual,
};

NSLayoutConstraint * Layout(UIView *from, LYSLayoutAttr attr1, LYSLayoutRelation by, UIView *to, LYSLayoutAttr attr2, CGFloat m, CGFloat c)
{
    return [NSLayoutConstraint constraintWithItem:from
                                        attribute:(NSLayoutAttribute)attr1
                                        relatedBy:(NSLayoutRelation)by
                                           toItem:to
                                        attribute:(NSLayoutAttribute)attr2
                                       multiplier:m
                                         constant:c];
}

typedef struct {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger week;
} LYSPickerDate;

LYSPickerDate transformFromDate(NSDate *date)
{
    LYSPickerDate lysDate;
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday fromDate:date];
    lysDate.year = [component year];
    lysDate.month = [component month];
    lysDate.day = [component day];
    lysDate.hour = [component hour];
    lysDate.minute = [component minute];
    lysDate.week = [component weekday];
    return lysDate;
}

@interface LYSDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic, strong)                UIPickerView        *pickerView;
@property (nonatomic,strong)                UIDatePicker        *datePicker;

@property (nonatomic,assign)                NSInteger           currentYear;
@property (nonatomic,assign)                NSInteger           currentMonth;
@property (nonatomic,assign)                NSInteger           currentDay;
@property (nonatomic,assign)                NSInteger           currentHour;
@property (nonatomic,assign)                NSInteger           currentMinute;

@property (nonatomic,assign) NSInteger dayNum;

@end

@implementation LYSDatePickerView

- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self defaultParms];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultParms];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self defaultParms];
    }
    return self;
}

/// 设置默认值
- (void)defaultParms
{
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    self.enableShowHeader = YES;
    self.headerHeight = 40;
    self.datePickerMode = LYSDatePickerModeDateAndTime;
    self.fromYear = 1900;
    self.toYear = 2100;
    self.date = [NSDate date];
    self.dayNum = 31;
}

- (void)didMoveToSuperview
{
    [self additionSubViews];
}

/// 添加子视图
- (void)additionSubViews
{
    [self applyHeaderView];
    if (self.type == LYSDatePickerTypeSystem) {
        [self applySystemPicker];
    }
    if (self.type == LYSDatePickerTypeCustom) {
        [self applyCustomPicker];
    }
}

- (void)applyHeaderView
{
    if (self.enableShowHeader)
    {
        self.headerView = [[LYSDateHeadrView alloc] init];
        [self addSubview:self.headerView];
        self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(self.headerView,  Left,    Equal,  self,   Left,            1.0f, 0).active = YES;
        Layout(self.headerView,  Top,     Equal,  self,   Top,             1.0f, 0).active = YES;
        Layout(self.headerView,  Right,   Equal,  self,   Right,           1.0f, 0).active = YES;
        Layout(self.headerView,  Height,  Equal,  nil,    NotAnAttribute,  1.0f, self.headerHeight).active = YES;
    }
}

- (void)applySystemPicker
{
    NSAssert(self.datePickerMode != LYSDatePickerModeYearAndDate, @"System-provided date picker does not have LYSDatePickerModeYearAndDate style, You can set the LYSDatePickerType type to update using a custom date picker");
    NSAssert(self.datePickerMode != LYSDatePickerModeYearAndDateAndTime, @"System-provided date picker does not have LYSDatePickerModeYearAndDateAndTime style, You can set the LYSDatePickerType type to update using a custom date picker");
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = (UIDatePickerMode)self.datePickerMode;
    self.datePicker.minimumDate = self.minimumDate;
    self.datePicker.maximumDate = self.maximumDate;
    self.datePicker.date = self.date;
    [self addSubview:self.datePicker];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat height = self.enableShowHeader ? self.headerHeight : 0;
    Layout(self.datePicker, Top,    Equal, self,  Top,            1.0f, height).active = YES;
    Layout(self.datePicker, Left,   Equal, self,  Left,           1.0f, 0).active = YES;
    Layout(self.datePicker, Right,  Equal, self,  Right,          1.0f, 0).active = YES;
    Layout(self.datePicker, Bottom, Equal, self,  Bottom,         1.0f, 0).active = YES;
}

- (void)applyCustomPicker
{
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat height = self.enableShowHeader ? self.headerHeight : 0;
    Layout(self.pickerView, Top,    Equal, self,  Top,            1.0f, height).active = YES;
    Layout(self.pickerView, Left,   Equal, self,  Left,           1.0f, 0).active = YES;
    Layout(self.pickerView, Right,  Equal, self,  Right,          1.0f, 0).active = YES;
    Layout(self.pickerView, Bottom, Equal, self,  Bottom,         1.0f, 0).active = YES;
    
    [self initCurrentDate];
}

- (void)initCurrentDate
{
    LYSPickerDate lysDate = transformFromDate(self.date);
    self.currentYear = lysDate.year - self.fromYear - 1;
    self.currentMonth = lysDate.month - 1;
    self.currentDay = lysDate.day - 1;
    self.currentHour = lysDate.hour - 1;
    self.currentMinute = lysDate.minute - 1;
    
    switch (self.datePickerMode) {
        case LYSDatePickerModeTime:
        {
            [self.pickerView selectRow:lysDate.hour-1 inComponent:0 animated:YES];
            [self.pickerView selectRow:lysDate.minute-1 inComponent:1 animated:YES];
        }
            break;
        case LYSDatePickerModeDate:
        {
            [self.pickerView selectRow:lysDate.month-1 inComponent:0 animated:YES];
            [self.pickerView selectRow:lysDate.day-1 inComponent:1 animated:YES];
        }
            break;
        case LYSDatePickerModeDateAndTime:
        {
            [self.pickerView selectRow:lysDate.month-1 inComponent:0 animated:YES];
            [self.pickerView selectRow:lysDate.day-1 inComponent:1 animated:YES];
            [self.pickerView selectRow:lysDate.hour-1 inComponent:2 animated:YES];
            [self.pickerView selectRow:lysDate.minute-1 inComponent:3 animated:YES];
        }
            break;
        case LYSDatePickerModeYearAndDate:
        {
            [self.pickerView selectRow:lysDate.year-self.fromYear-1 inComponent:0 animated:YES];
            [self.pickerView selectRow:lysDate.month-1 inComponent:1 animated:YES];
            [self.pickerView selectRow:lysDate.day-1 inComponent:2 animated:YES];
        }
            break;
        case LYSDatePickerModeYearAndDateAndTime:
        {
            [self.pickerView selectRow:lysDate.year-self.fromYear-1 inComponent:0 animated:YES];
            [self.pickerView selectRow:lysDate.month-1 inComponent:1 animated:YES];
            [self.pickerView selectRow:lysDate.day-1 inComponent:2 animated:YES];
            [self.pickerView selectRow:lysDate.hour-1 inComponent:3 animated:YES];
            [self.pickerView selectRow:lysDate.minute-1 inComponent:4 animated:YES];
        }
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.datePickerMode) {
        case LYSDatePickerModeTime:
            return 2;
            break;
        case LYSDatePickerModeDate:
            return 3;
            break;
        case LYSDatePickerModeDateAndTime:
            return 4;
            break;
        case LYSDatePickerModeYearAndDate:
            return 3;
            break;
        case LYSDatePickerModeYearAndDateAndTime:
            return 5;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (self.datePickerMode) {
        case LYSDatePickerModeTime:
        {
            switch (component) {
                case 0:
                    return 24;
                    break;
                case 1:
                    return 60;
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeDate:
        {
            switch (component) {
                case 0:
                    return 12;
                    break;
                case 1:
                    return self.dayNum;
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeDateAndTime:
        {
            switch (component) {
                case 0:
                    return 12;
                    break;
                case 1:
                    return self.dayNum;
                    break;
                case 2:
                    return 24;
                    break;
                case 3:
                    return 60;
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeYearAndDate:
        {
            switch (component) {
                case 0:
                    return self.toYear - self.fromYear;
                    break;
                case 1:
                    return 12;
                    break;
                case 2:
                    return self.dayNum;
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeYearAndDateAndTime:
        {
            switch (component) {
                case 0:
                    return self.toYear - self.fromYear;
                    break;
                case 1:
                    return 12;
                    break;
                case 2:
                    return self.dayNum;
                    break;
                case 3:
                    return 24;
                    break;
                case 4:
                    return 60;
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.backgroundColor = [UIColor redColor];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (self.datePickerMode) {
        case LYSDatePickerModeTime:
        {
            switch (component) {
                case 0:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 1:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeDate:
        {
            switch (component) {
                case 0:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 1:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeDateAndTime:
        {
            switch (component) {
                case 0:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 1:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 2:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 3:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeYearAndDate:
        {
            switch (component) {
                case 0:
                    return [NSString stringWithFormat:@"%ld",self.fromYear + row+1];
                    break;
                case 1:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 2:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        case LYSDatePickerModeYearAndDateAndTime:
        {
            switch (component) {
                case 0:
                    return [NSString stringWithFormat:@"%ld",self.fromYear + row+1];
                    break;
                case 1:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 2:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 3:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                case 4:
                    return [NSString stringWithFormat:@"%ld",row+1];
                    break;
                default:
                    return 0;
                    break;
            }
        }
            break;
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.datePickerMode) {
        case LYSDatePickerModeTime:
        {
            switch (component) {
                case 0:
                {
                    self.currentHour = row + 1;
                }
                    break;
                case 1:
                {
                    self.currentMinute = row + 1;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerModeDate:
        {
            switch (component) {
                case 0:
                {
                    self.currentMonth = row + 1;
                    [self judgeLeapYearWith:1];
                }
                    break;
                case 1:
                {
                    self.currentDay = row + 1;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerModeDateAndTime:
        {
            switch (component) {
                case 0:
                {
                    self.currentMonth = row + 1;
                    [self judgeLeapYearWith:1];
                }
                    break;
                case 1:
                {
                    self.currentDay = row + 1;
                }
                    break;
                case 2:
                {
                    self.currentHour = row + 1;
                }
                    break;
                case 3:
                {
                    self.currentMinute = row + 1;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerModeYearAndDate:
        {
            switch (component) {
                case 0:
                {
                    self.currentYear = self.fromYear + row + 1;
                    [self judgeLeapYearWith:2];
                }
                    break;
                case 1:
                {
                    self.currentMonth = row + 1;
                    [self judgeLeapYearWith:2];
                }
                    break;
                case 2:
                {
                    self.currentDay = row + 1;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerModeYearAndDateAndTime:
        {
            switch (component) {
                case 0:
                {
                    self.currentYear = self.fromYear + row + 1;
                    [self judgeLeapYearWith:2];
                }
                    break;
                case 1:
                {
                    self.currentMonth = row + 1;
                    [self judgeLeapYearWith:2];
                }
                    break;
                case 2:
                {
                    self.currentDay = row + 1;
                }
                    break;
                case 3:
                {
                    self.currentHour = row + 1;
                }
                    break;
                case 4:
                {
                    self.currentMinute = row + 1;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            
            break;
    }
}

- (void)judgeLeapYearWith:(NSInteger)index
{
    if ([@[@1,@3,@5,@7,@8,@10,@12] containsObject:@(self.currentMonth)]) {
        self.dayNum = 31;
    }
    if ([@[@4,@6,@9,@11] containsObject:@(self.currentMonth)]) {
        self.dayNum = 30;
    }
    if (self.currentMonth == 2) {
        
        if (self.currentYear % 100 == 0) {
            if (self.currentYear % 400 == 0) {
                self.dayNum = 29;
            } else {
                self.dayNum = 28;
            }
        } else {
            if (self.currentYear % 4 == 0) {
                self.dayNum = 29;
            } else {
                self.dayNum = 28;
            }
        }
    }
    [self.pickerView reloadComponent:index];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 50;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

@end
