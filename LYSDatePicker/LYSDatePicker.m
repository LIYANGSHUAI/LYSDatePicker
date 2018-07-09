//
//  LYSDatePicker.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePicker.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, LYSLayoutAttr) {
    Left                    = NSLayoutAttributeLeft,                        // left
    Right                   = NSLayoutAttributeRight,                       // right
    Top                     = NSLayoutAttributeTop,                         // top
    Bottom                  = NSLayoutAttributeBottom,                      // bottom
    Width                   = NSLayoutAttributeWidth,                       // width
    Height                  = NSLayoutAttributeHeight,                      // height
    CenterX                 = NSLayoutAttributeCenterX,                     // centerX
    CenterY                 = NSLayoutAttributeCenterY,                     // centerY
    NotAnAttribute          = NSLayoutAttributeNotAnAttribute               // NotAnAttribute
};

typedef NS_ENUM(NSInteger, LYSLayoutRelation) {
    LessThanOrEqual         = NSLayoutRelationLessThanOrEqual,              // LessThan
    Equal                   = NSLayoutRelationEqual,                        // Equal
    GreaterThanOrEqual      = NSLayoutRelationGreaterThanOrEqual,           // GreaterThan
};

/**
 add a NSLayoutConstraint for View
 
 @param from        setting View
 @param attr1       LYSLayoutAttr
 @param by          LYSLayoutRelation
 @param to          reference View
 @param attr2       LYSLayoutAttr
 @param m           multiplier
 @param c           constant
 @return            NSLayoutConstraint
 */
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

/*
 Parse an NSDate object to get basic information about the date
 */
typedef struct {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger week;
    NSInteger timeType;
} LYSPickerDate;

/**
 Convert an NSDate object to a LYSPickerDate type
 
 @param date        Incoming date
 @return            the LYSPickerDate type
 */
LYSPickerDate transformFromDate(NSDate *date)
{
    LYSPickerDate lysDate;
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday fromDate:date];
    lysDate.year        = [component year];
    lysDate.month       = [component month];
    lysDate.day         = [component day];
    lysDate.hour        = [component hour];
    lysDate.minute      = [component minute];
    lysDate.week        = [component weekday];
    lysDate.timeType    = lysDate.hour <= 11 ? 0 : 1;
    return lysDate;
}

/**
 Convert an LYSPickerDate object to a NSDate type
 
 @param date NSDate
 @return LYSPickerDate
 */
NSDate * transformFromPickerDate(LYSPickerDate date)
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    [components setYear:date.year];
    [components setMonth:date.month];
    [components setDay:date.day];
    [components setHour:date.hour];
    [components setMinute:date.minute];
    NSDate *firstDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    return firstDate;
}

/**
 get weakDay of LYSPickerDate
 
 @param date LYSPickerDate
 @return weakDay
 */
NSInteger weekDayOfFirstDate(LYSPickerDate date)
{
    NSDate *tempDate = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:tempDate];
    [components setYear:date.year];
    [components setMonth:date.month];
    [components setDay:1];
    NSDate *firstDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    NSInteger index = [[NSCalendar currentCalendar] component:(NSCalendarUnitWeekday) fromDate:firstDate];
    return index;
}

/**
 update the year of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param year        the year
 @return            LYSPickerDate
 */
LYSPickerDate updateYear(LYSPickerDate date, NSInteger year)
{
    LYSPickerDate tempDate = date;
    tempDate.year = year;
    return tempDate;
}

/**
 update the month of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param month       the month
 @return            LYSPickerDate
 */
LYSPickerDate updateMonth(LYSPickerDate date, NSInteger month)
{
    LYSPickerDate tempDate = date;
    tempDate.month = month;
    return tempDate;
}

/**
 update the day of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param day         the day
 @return            LYSPickerDate
 */
LYSPickerDate updateDay(LYSPickerDate date, NSInteger day)
{
    LYSPickerDate tempDate = date;
    tempDate.day = day;
    return tempDate;
}

/**
 update the hour of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param hour        the hour
 @return            LYSPickerDate
 */
LYSPickerDate updateHour(LYSPickerDate date, NSInteger hour)
{
    LYSPickerDate tempDate = date;
    tempDate.hour = hour;
    return tempDate;
}

/**
 update the minute of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param minute      the minute
 @return            LYSPickerDate
 */
LYSPickerDate updateMinute(LYSPickerDate date, NSInteger minute)
{
    LYSPickerDate tempDate = date;
    tempDate.minute = minute;
    return tempDate;
}

/**
 update the week of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param week        the week
 @return            LYSPickerDate
 */
LYSPickerDate updateWeek(LYSPickerDate date, NSInteger week)
{
    LYSPickerDate tempDate = date;
    tempDate.week = week;
    return tempDate;
}

/**
 update the timeType of the LYSPickerDate type
 
 @param date        the LYSPickerDate type
 @param timeType        the timeType
 @return            LYSPickerDate
 */
LYSPickerDate updateTimeType(LYSPickerDate date, NSInteger timeType)
{
    LYSPickerDate tempDate = date;
    tempDate.timeType = timeType;
    return tempDate;
}

typedef NS_ENUM(NSUInteger, LYSMonthType) {
    LYSMonthTypeGeneralLongMonth,                     // 31
    LYSMonthTypeGeneralShortMonth,                    // 30
    LYSMonthTypeLeapYearLongMonth,                    // 29
    LYSMonthTypeLeapYearShortMonth                    // 28
};

/*
 Determine whether it is a leap year
 */
BOOL judgeLeapYear(LYSPickerDate date)
{
    if (date.year % 100 == 0) {
        if (date.year % 400 == 0) {return YES;} else {return NO;}
    } else {
        if (date.year % 4 == 0) {return YES;} else {return NO;}
    }
}

/*
 Determine if it is a long month
 */
BOOL judgeLongMonth(LYSPickerDate date)
{
    if ([@[@1,@3,@5,@7,@8,@10,@12] containsObject:@(date.month)]) {
        return YES;
    }
    if ([@[@4,@6,@9,@11] containsObject:@(date.month)]) {
        return NO;
    }
    return NO;  /// February
}

/*
 Determine the type of a month
 */
LYSMonthType judgeMonthType(LYSPickerDate date)
{
    if (judgeLongMonth(date)) {
        return LYSMonthTypeGeneralLongMonth;
    } else {
        if (date.month != 2) {
            return LYSMonthTypeGeneralShortMonth;
        } else {
            if (judgeLeapYear(date)) {
                return LYSMonthTypeLeapYearLongMonth;
            } else {
                return LYSMonthTypeLeapYearShortMonth;
            }
        }
    }
}

#define WARN(A,B) \
{\
if (A) {\
NSLog(@">>>>>>>\nWARN:%@\n>>>>>>>",B);\
}\
}\

#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif

#define Format(...)                 [NSString stringWithFormat:__VA_ARGS__]

#define Crossroads(judge,A,B)       (judge ? (A) : (B))

#define Match(A,B)                  {if (A) B}

#define Type(A)                     (self.type == (LYSDatePickerType##A))
#define DatePickerMode(A)           (self.datePickerMode == (LYSDatePickerMode##A))
#define HourStandard(A)             (self.hourStandard == (LYSDatePickerStandard##A))
#define WeekDayType(A)              (self.weekDayType == LYSDatePickerWeekDayType##A)

#define MatchType(A,B)              {if (self.type == (LYSDatePickerType##A)) B}
#define MatchDatePickerMode(A,B)    {if (self.datePickerMode == (LYSDatePickerMode##A)) B}
#define MatchHourStandard(A,B)      {if (self.hourStandard == (LYSDatePickerStandard##A)) B}
#define MatchWeekDayType(A,B)       {if (self.weekDayType == (LYSDatePickerWeekDayType##A)) B}

NSString *const LYSDatePickerDidSelectDateNotifition = @"LYSDatePickerDidSelectDateNotifition";

@interface LYSDatePicker ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)  UIPickerView        *pickerView;
@property (nonatomic, strong)  UIDatePicker        *datePicker;
@property (nonatomic, assign)  LYSPickerDate       currentDate;
@property (nonatomic, assign)  NSInteger           dayNum;
@property (nonatomic, assign)  NSInteger           weekDayOfFirstDate;
@property (nonatomic, strong)  NSArray             *weekDayStrArr;
@end

@implementation LYSDatePicker

#pragma mark - Override initialization method -
- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self defaultParms];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type mode:(LYSDatePickerMode)mode
{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.datePickerMode = mode;
        [self defaultParms];
    }
    return self;
}

+ (instancetype)datePickerWithType:(LYSDatePickerType)type
{
    LYSDatePicker *datePicker = [[self alloc] init];
    datePicker.type = type;
    [datePicker defaultParms];
    return datePicker;
}

+ (instancetype)datePickerWithType:(LYSDatePickerType)type mode:(LYSDatePickerMode)mode
{
    LYSDatePicker *datePicker = [[self alloc] init];
    datePicker.type = type;
    datePicker.datePickerMode = mode;
    [datePicker defaultParms];
    return datePicker;
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

/*
 In the case that enableShowHeader is YES, if the user does not set the headerView, but the headerHeight is not 0, this time, by default, a default top status bar LYSDateHeadrView is created.
 */
- (LYSDateHeadrView *)headerView
{
    if (!_headerView) {
        _headerView = [[LYSDateHeadrView alloc] init];
    }
    return _headerView;
}

/*
 didMoveToSuperview This method is a parent class met hod, the current view has been added to the parent view trigger, the purpose of component rendering in this method is mainly to prevent the component from modifying some properties after initialization, can not immediately render the problem
 */
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    Match(self.superview, [self additionSubViews];)
}

#pragma mark - Set default value -
- (void)defaultParms
{
    self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
    self.enableShowHeader = YES;
    self.headerHeight = 40;
    self.contentColor = [UIColor whiteColor];
    self.datePickerMode = LYSDatePickerModeDateAndTime;
    self.fromYear = 1900;
    self.toYear = 2100;
    self.date = [NSDate date];
    self.minimumDate = nil;
    self.maximumDate = nil;
    self.dayNum = 31;
    self.hourStandard = LYSDatePickerStandardDefault;
    self.AMStr = @"AM";
    self.PMStr = @"PM";
    self.rowHeight = 40;
    self.allowShowUnit = YES;
    self.weekDayType = LYSDatePickerWeekDayTypeNone;
    self.labelFont = [UIFont systemFontOfSize:16];
    self.labelColor = [UIColor blackColor];
}

- (NSArray *)weekDayStrArr
{
    MatchWeekDayType(Custom, {
        NSAssert((self.weekDayArr && [self.weekDayArr count] == 7), @"Because the date type you set is LYSDatePickerWeekDayTypeCustom, the weekDayArr parameter must be set, and the number of elements can only be 7");
        return self.weekDayArr;
    })
    
    NSArray *weekDayStrArr = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSArray *shortWeekdaySymbols = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSArray *veryShortWeekdaySymbols = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    MatchWeekDayType(WeekdaySymbols,                {_weekDayStrArr = nil;})
    MatchWeekDayType(WeekdaySymbols,                {_weekDayStrArr = weekDayStrArr;})
    MatchWeekDayType(ShortWeekdaySymbols,           {_weekDayStrArr = shortWeekdaySymbols;})
    MatchWeekDayType(VeryShortWeekdaySymbols,       {_weekDayStrArr = veryShortWeekdaySymbols;})
    return _weekDayStrArr;
}

#pragma mark - Add a subview -
- (void)additionSubViews
{
    [self applyHeaderView];
    WARN(self.date == nil, @"The date passed in cannot be empty, and the corresponding conversion is made here. If the incoming date is empty, the current date is selected by default.\n Update the value of this property to remove this warning @property (nonnull, nonatomic, strong) NSDate *date;")
    Match(self.date == nil, self.date = [NSDate date];)
    MatchType(System, [self applySystemPicker];);
    MatchType(Custom, [self applyCustomPicker];);
}

- (void)applyHeaderView
{
    if (self.enableShowHeader)
    {
        [self addSubview:self.headerView];
        self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(self.headerView,  Left,    Equal,  self,   Left,            1.0f, 0).active = YES;
        Layout(self.headerView,  Top,     Equal,  self,   Top,             1.0f, 0).active = YES;
        Layout(self.headerView,  Right,   Equal,  self,   Right,           1.0f, 0).active = YES;
        Layout(self.headerView,  Height,  Equal,  nil,    NotAnAttribute,  1.0f, self.headerHeight).active = YES;
        [self layoutIfNeeded];
    }
}

- (void)applySystemPicker
{
    NSAssert(self.datePickerMode != LYSDatePickerModeYearAndDate, @"System-provided date picker does not have LYSDatePickerModeYearAndDate style, You can set the LYSDatePickerType type to update using a custom date picker");
    NSAssert(self.datePickerMode != LYSDatePickerModeYearAndDateAndTime, @"System-provided date picker does not have LYSDatePickerModeYearAndDateAndTime style, You can set the LYSDatePickerType type to update using a custom date picker");
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.backgroundColor = self.contentColor;
    self.datePicker.datePickerMode = (UIDatePickerMode)self.datePickerMode;
    self.datePicker.minimumDate = self.minimumDate;
    self.datePicker.maximumDate = self.maximumDate;
    self.datePicker.date = self.date;
    [self addSubview:self.datePicker];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat height = Crossroads(self.enableShowHeader, self.headerHeight, 0);
    Layout(self.datePicker, Top,    Equal, self,  Top,            1.0f, height).active = YES;
    Layout(self.datePicker, Left,   Equal, self,  Left,           1.0f, 0).active = YES;
    Layout(self.datePicker, Right,  Equal, self,  Right,          1.0f, 0).active = YES;
    Layout(self.datePicker, Bottom, Equal, self,  Bottom,         1.0f, 0).active = YES;
    [self layoutIfNeeded];
    
    [self.datePicker addTarget:self action:@selector(changeDate:) forControlEvents:(UIControlEventValueChanged)];
}

- (void)changeDate:(UIDatePicker *)sender
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(datePicker:didSelectDate:)]) {
        [self.dataSource datePicker:self didSelectDate:sender.date];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidSelectDateNotifition object:nil userInfo:@{@"value":sender.date}];
}

- (void)applyCustomPicker
{
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.backgroundColor = self.contentColor;
    [self addSubview:self.pickerView];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat height = Crossroads(self.enableShowHeader, self.headerHeight, 0);
    Layout(self.pickerView, Top,    Equal, self,  Top,            1.0f, height).active = YES;
    Layout(self.pickerView, Left,   Equal, self,  Left,           1.0f, 0).active = YES;
    Layout(self.pickerView, Right,  Equal, self,  Right,          1.0f, 0).active = YES;
    Layout(self.pickerView, Bottom, Equal, self,  Bottom,         1.0f, 0).active = YES;
    [self layoutIfNeeded];
    
    self.currentDate = transformFromDate(self.date);
    [self selectDate:self.currentDate];
}

- (void)updateDate:(NSDate *)date
{
    MatchType(System, {self.datePicker.date = date;})
    MatchType(Custom, {self.currentDate = transformFromDate(self.date);[self selectDate:self.currentDate];})
}

- (void)selectDate:(LYSPickerDate)date
{
    NSInteger yearIndex                         = date.year-self.fromYear-1;
    NSInteger monthIndex                        = date.month-1;
    NSInteger dayIndex                          = date.day-1;
    NSInteger hourIndex_12                      = Crossroads(date.hour == 0, 23, (date.hour-1));
    NSInteger hourIndex_24                      = date.hour;
    NSInteger minuteIndex                       = date.minute;
    
    MatchDatePickerMode(Time, {
        NSInteger hourValue = 0;
        MatchHourStandard(24Hour, {hourValue = hourIndex_24;})
        MatchHourStandard(12Hour, {hourValue = hourIndex_12;})
        [self.pickerView selectRow:hourValue inComponent:0 animated:YES];
        [self.pickerView selectRow:minuteIndex inComponent:1 animated:YES];
    })
    
    MatchDatePickerMode(Date, {
        [self.pickerView selectRow:monthIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:dayIndex inComponent:1 animated:YES];
    })
    
    MatchDatePickerMode(DateAndTime, {
        NSInteger hourValue = 0;
        MatchHourStandard(24Hour, {hourValue = hourIndex_24;})
        MatchHourStandard(12Hour, {hourValue = hourIndex_12;})
        [self.pickerView selectRow:monthIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:dayIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:hourValue inComponent:2 animated:YES];
        [self.pickerView selectRow:minuteIndex inComponent:3 animated:YES];
    })
    
    MatchDatePickerMode(YearAndDate, {
        [self.pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:dayIndex inComponent:2 animated:YES];
    })
    
    MatchDatePickerMode(YearAndDateAndTime, {
        NSInteger hourValue = 0;
        MatchHourStandard(24Hour, {hourValue = hourIndex_24;})
        MatchHourStandard(12Hour, {hourValue = hourIndex_12;})
        [self.pickerView selectRow:yearIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:monthIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:dayIndex inComponent:2 animated:YES];
        [self.pickerView selectRow:hourValue inComponent:3 animated:YES];
        [self.pickerView selectRow:minuteIndex inComponent:4 animated:YES];
    })
    [self monitorCurrentDate];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    MatchDatePickerMode(Time,                   {return Crossroads(HourStandard(12Hour), 3, 2);})
    MatchDatePickerMode(Date,                   {return 2;})
    MatchDatePickerMode(DateAndTime,            {return Crossroads(HourStandard(12Hour), 5, 4);})
    MatchDatePickerMode(YearAndDate,            {return 3;})
    MatchDatePickerMode(YearAndDateAndTime,     {return Crossroads(HourStandard(12Hour), 6, 5);})
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger yearIndex                         = self.toYear - self.fromYear;
    NSInteger monthIndex                        = 12;
    NSInteger dayIndex                          = self.dayNum;
    NSInteger hourIndex                         = 24;
    NSInteger minuteIndex                       = 60;
    NSInteger timeTypeIndex                     = 2;
    
    MatchDatePickerMode(Time, {
        Match(component == 0,                   {return hourIndex;})
        Match(component == 1,                   {return minuteIndex;})
        Match(component == 2,                   {return timeTypeIndex;})
    })
    
    MatchDatePickerMode(Date, {
        Match(component == 0,                   {return monthIndex;})
        Match(component == 1,                   {return dayIndex;})
    })
    
    MatchDatePickerMode(DateAndTime, {
        Match(component == 0,                   {return monthIndex;})
        Match(component == 1,                   {return dayIndex;})
        Match(component == 2,                   {return hourIndex;})
        Match(component == 3,                   {return minuteIndex;})
        Match(component == 4,                   {return timeTypeIndex;})
    })
    
    MatchDatePickerMode(YearAndDate, {
        Match(component == 0,                   {return yearIndex;})
        Match(component == 1,                   {return monthIndex;})
        Match(component == 2,                   {return dayIndex;})
    })
    
    MatchDatePickerMode(YearAndDateAndTime, {
        Match(component == 0,                   {return yearIndex;})
        Match(component == 1,                   {return monthIndex;})
        Match(component == 2,                   {return dayIndex;})
        Match(component == 3,                   {return hourIndex;})
        Match(component == 4,                   {return minuteIndex;})
        Match(component == 5,                   {return timeTypeIndex;})
    })
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    if (!label) {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.textColor = self.labelColor;
    label.font = self.labelFont;
//    label.backgroundColor = [UIColor redColor];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *yearValue                         = Format(@"%ld",(long)(self.fromYear + row+1));
    NSString *monthValue                        = Format(@"%ld",(long)(row+1));
    NSString *dayValue                          = Format(@"%ld",(long)(row+1));
    NSString *hourValue_12                      = Crossroads(row <= 11, Format(@"%ld",(long)(row+1)), Format(@"%ld",(long)(row-11)));
    NSString *hourValue_24                      = Crossroads(row < 10, Format(@"0%ld",(long)row), Format(@"%ld",(long)row));
    NSString *minuteValue                       = Crossroads(row < 10, Format(@"0%ld",(long)row), Format(@"%ld",(long)row));
    NSString *timeTypeValue                     = Crossroads(row == 0, self.AMStr, self.PMStr);
    
    Match(self.allowShowUnit, {
        yearValue                               = Format(@"%@年",yearValue);;
        monthValue                              = Format(@"%@月",monthValue);
        dayValue                                = Format(@"%@日",dayValue);
        hourValue_12                            = Format(@"%@时",hourValue_12);
        hourValue_24                            = Format(@"%@时",hourValue_24);
        minuteValue                             = Format(@"%@分",minuteValue);
        timeTypeValue                           = Format(@"%@",timeTypeValue);
    })
    
    Match(self.weekDayType != LYSDatePickerWeekDayTypeNone, {
        NSInteger tempWeekDay                   = (self.weekDayOfFirstDate+row)%7;
        NSInteger tempWeekIndex                 = Crossroads(tempWeekDay == 0, 7, tempWeekDay);
        NSString  *weekDay                      = Format(@"%@",[self.weekDayStrArr objectAtIndex:tempWeekIndex-1]);
        dayValue                                = Format(@"%@ %@",dayValue, weekDay);
    })
    
    MatchDatePickerMode(Time, {
        Match(component == 0,
              {
                  MatchHourStandard(24Hour,     {return hourValue_24;})
                  MatchHourStandard(12Hour,     {return hourValue_12;})
              })
        Match(component == 1,                   {return minuteValue;})
        Match(component == 2,                   {return timeTypeValue;})
    })
    
    MatchDatePickerMode(Date, {
        Match(component == 0,                   {return monthValue;})
        Match(component == 1,                   {return dayValue;})
    })
    
    MatchDatePickerMode(DateAndTime, {
        Match(component == 0,                   {return monthValue;})
        Match(component == 1,                   {return dayValue;})
        Match(component == 2,
              {
                  MatchHourStandard(24Hour,     {return hourValue_24;})
                  MatchHourStandard(12Hour,     {return hourValue_12;})
              })
        Match(component == 3,                   {return minuteValue;})
        Match(component == 4,                   {return timeTypeValue;})
    })
    
    MatchDatePickerMode(YearAndDate, {
        Match(component == 0,                   {return yearValue;})
        Match(component == 1,                   {return monthValue;})
        Match(component == 2,                   {return dayValue;})
    })
    
    MatchDatePickerMode(YearAndDateAndTime, {
        Match(component == 0,                   {return yearValue;})
        Match(component == 1,                   {return monthValue;})
        Match(component == 2,                   {return dayValue;})
        Match(component == 3,
              {
                  MatchHourStandard(24Hour,     {return hourValue_24;})
                  MatchHourStandard(12Hour,     {return hourValue_12;})
              })
        Match(component == 4,                   {return minuteValue;})
        Match(component == 5,                   {return timeTypeValue;})
    })
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger yearIndex                         = self.fromYear + row + 1;
    NSInteger monthIndex                        = row+1;
    NSInteger dayIndex                          = row+1;
    NSInteger hourIndex_12                      = Crossroads(row == 23, 0, row+1);
    NSInteger hourIndex_24                      = row;
    NSInteger minuteIndex                       = row;
    NSInteger timeTypeIndex                     = row;
    
    MatchDatePickerMode(Time, {
        Match(component == 0,
              {
                  MatchHourStandard(24Hour,     {self.currentDate = updateHour(self.currentDate, hourIndex_24);});
                  MatchHourStandard(12Hour,     {self.currentDate = updateHour(self.currentDate, hourIndex_12);});
              })
        Match(component == 1,                   {self.currentDate = updateMinute(self.currentDate, minuteIndex);})
        Match(component == 2,                   {self.currentDate = updateTimeType(self.currentDate, timeTypeIndex);})
    })
    
    MatchDatePickerMode(Date, {
        Match(component == 0,                   {self.currentDate = updateMonth(self.currentDate, monthIndex);})
        Match(component == 1,                   {self.currentDate = updateDay(self.currentDate, dayIndex);})
    })
    
    MatchDatePickerMode(DateAndTime, {
        Match(component == 0,                   {self.currentDate = updateMonth(self.currentDate, monthIndex);})
        Match(component == 1,                   {self.currentDate = updateDay(self.currentDate, dayIndex);})
        Match(component == 2,
              {
                  MatchHourStandard(24Hour,     {self.currentDate = updateHour(self.currentDate, hourIndex_24);});
                  MatchHourStandard(12Hour,     {self.currentDate = updateHour(self.currentDate, hourIndex_12);});
              })
        Match(component == 3,                   {self.currentDate = updateMinute(self.currentDate, minuteIndex);})
        Match(component == 4,                   {self.currentDate = updateTimeType(self.currentDate, timeTypeIndex);})
    })
    
    MatchDatePickerMode(YearAndDate, {
        Match(component == 0,                   {self.currentDate = updateYear(self.currentDate, yearIndex);})
        Match(component == 1,                   {self.currentDate = updateMonth(self.currentDate, monthIndex);})
        Match(component == 2,                   {self.currentDate = updateDay(self.currentDate, dayIndex);})
    })
    
    MatchDatePickerMode(YearAndDateAndTime, {
        Match(component == 0,                   {self.currentDate = updateYear(self.currentDate, yearIndex);})
        Match(component == 1,                   {self.currentDate = updateMonth(self.currentDate, monthIndex);})
        Match(component == 2,                   {self.currentDate = updateDay(self.currentDate, dayIndex);})
        Match(component == 3, {
            MatchHourStandard(24Hour,           {self.currentDate = updateHour(self.currentDate, hourIndex_24);});
            MatchHourStandard(12Hour,           {self.currentDate = updateHour(self.currentDate, hourIndex_12);});
        })
        Match(component == 4,                   {self.currentDate = updateMinute(self.currentDate, minuteIndex);})
        Match(component == 5,                   {self.currentDate = updateTimeType(self.currentDate, timeTypeIndex);})
    })
    
    /// Monitor leap year
    [self monitorCurrentDate];
    
    NSDate *date = transformFromPickerDate(self.currentDate);
    
    /// Compare dates, limit dates between maximum and minimum dates
    [self compareDate:date];
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(datePicker:didSelectDate:)]) {
        [self.dataSource datePicker:self didSelectDate:date];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidSelectDateNotifition object:nil userInfo:@{@"value":date}];
}

- (void)compareDate:(NSDate *)date
{
    Match(self.minimumDate, {
        NSComparisonResult miniResult = [[NSCalendar currentCalendar] compareDate:self.minimumDate toDate:date toUnitGranularity:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute];
        if (miniResult == NSOrderedDescending) {
            self.currentDate = transformFromDate(self.minimumDate);
            [self selectDate:self.currentDate];
        }
    })
    Match(self.maximumDate, {
        NSComparisonResult maxResult = [[NSCalendar currentCalendar] compareDate:self.maximumDate toDate:date toUnitGranularity:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute];
        if (maxResult == NSOrderedAscending) {
            self.currentDate = transformFromDate(self.maximumDate);
            [self selectDate:self.currentDate];
        }
    })
}

- (void)monitorCurrentDate
{
    MatchDatePickerMode(Time,                       {MatchHourStandard(12Hour, {[self judgeHourTypeWith:2];})})
    MatchDatePickerMode(Date,                       {[self judgeMonthNumAndRefresh:1];})
    MatchDatePickerMode(DateAndTime, {
        MatchHourStandard(12Hour,                   {[self judgeHourTypeWith:4];})
        [self judgeMonthNumAndRefresh:1];
    })
    MatchDatePickerMode(YearAndDate,                {[self judgeMonthNumAndRefresh:2];})
    MatchDatePickerMode(YearAndDateAndTime, {
        MatchHourStandard(12Hour,                   {[self judgeHourTypeWith:5];})
        [self judgeMonthNumAndRefresh:2];
    })
}

- (void)judgeHourTypeWith:(NSInteger)index
{
    if (self.currentDate.hour <= 11) {
        self.currentDate = updateTimeType(self.currentDate, 0);
        [self.pickerView selectRow:0 inComponent:index animated:YES];
    } else {
        self.currentDate = updateTimeType(self.currentDate, 1);
        [self.pickerView selectRow:1 inComponent:index animated:YES];
    }
}

- (void)judgeMonthNumAndRefresh:(NSInteger)index
{
    LYSMonthType monthType = judgeMonthType(self.currentDate);
    Match(monthType == LYSMonthTypeGeneralLongMonth,                                            self.dayNum = 31;);
    Match(monthType == LYSMonthTypeGeneralShortMonth,                                           self.dayNum = 30;);
    Match(monthType == LYSMonthTypeLeapYearLongMonth,                                           self.dayNum = 29;);
    Match(monthType == LYSMonthTypeLeapYearShortMonth,                                          self.dayNum = 28;);
    self.weekDayOfFirstDate = weekDayOfFirstDate(self.currentDate);
    [self.pickerView reloadComponent:index];
}

/// Because the system's date picker has no way to set the distance between the granularities, if you use the system date selector this proxy method does not work, and if it is customized, it will display normally.
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:componentWidthOfIndex:)]) {
        return [self.delegate datePicker:self componentWidthOfIndex:component];
    }
    
    CGFloat fontSize = self.labelFont.pointSize;
    
    CGFloat year = 50*fontSize/14;
    CGFloat month = 35*fontSize/14;
    CGFloat hour = 40*fontSize/14;
    CGFloat minute = 40*fontSize/14;
    CGFloat timeType = 30*fontSize/14;
    
    CGFloat day = 80*fontSize/14;
    
    MatchWeekDayType(None,                                  day = 60*fontSize/14;)
    MatchWeekDayType(WeekdaySymbols,                        day = 80*fontSize/14;)
    MatchWeekDayType(ShortWeekdaySymbols,                   day = 70*fontSize/14;)
    MatchWeekDayType(VeryShortWeekdaySymbols,               day = 60*fontSize/14;)
    MatchWeekDayType(Custom,                                day = 80*fontSize/14;)
    
    MatchDatePickerMode(Time,                   {
        Match(component == 0,                               {return hour;})
        Match(component == 1,                               {return minute;})
        Match(component == 2,                               {return timeType;})
    })
    MatchDatePickerMode(Date,                   {
        Match(component == 0,                               {return month;})
        Match(component == 1,                               {return day;})
    })
    MatchDatePickerMode(DateAndTime,            {
        Match(component == 0,                               {return month;})
        Match(component == 1,                               {return day;})
        Match(component == 2,                               {return hour;})
        Match(component == 3,                               {return minute;})
        Match(component == 4,                               {return timeType;})
    })
    MatchDatePickerMode(YearAndDate,            {
        Match(component == 0,                               {return year;})
        Match(component == 1,                               {return month;})
        Match(component == 2,                               {return day;})
    })
    MatchDatePickerMode(YearAndDateAndTime,     {
        Match(component == 0,                               {return year;})
        Match(component == 1,                               {return month;})
        Match(component == 2,                               {return day;})
        Match(component == 3,                               {return hour;})
        Match(component == 4,                               {return minute;})
        Match(component == 5,                               {return timeType;})
    })
    
    return 45;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.rowHeight;
}

@end

@implementation LYSDateHeaderBar
@end

typedef NS_ENUM(NSUInteger, LYSDateHeaderBarItemType) {
    LYSDateHeaderBarItemTypeTitle,
    LYSDateHeaderBarItemTypeImage,
    LYSDateHeaderBarItemTypeCustom,
};

@interface LYSDateHeaderBarItem ()
@property(nonatomic, copy, readwrite) NSString *title;
@property(nonatomic, strong, readwrite) UIImage *image;
@property(nonatomic, strong, readwrite) UIView *customView;
@property(nonatomic, strong) NSInvocation *invocation;
@property(nonatomic, assign) LYSDateHeaderBarItemType type;
@end

@implementation LYSDateHeaderBarItem
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    if (self = [super init]) {
        self.type = LYSDateHeaderBarItemTypeTitle;
        self.title = title;
        self.tintColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:16];
        NSMethodSignature *signature = [self methodSignatureForSelector:@selector(action:)];
        self.invocation = [NSInvocation invocationWithMethodSignature:signature];
        [self.invocation setTarget:target];
        [self.invocation setSelector:action];
        LYSDateHeaderBarItem *barItem = self;
        [self.invocation setArgument:&barItem atIndex:2];
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    if (self = [super init]) {
        self.type = LYSDateHeaderBarItemTypeImage;
        self.image = image;
        NSMethodSignature *signature = [self methodSignatureForSelector:@selector(action:)];
        self.invocation = [NSInvocation invocationWithMethodSignature:signature];
        [self.invocation setTarget:target];
        [self.invocation setSelector:action];
        LYSDateHeaderBarItem *barItem = self;
        [self.invocation setArgument:&barItem atIndex:2];
    }
    return self;
}
- (instancetype)initWithCustomView:(UIView *)customView
{
    if (self = [super init]) {
        self.type = LYSDateHeaderBarItemTypeCustom;
        self.customView = customView;
    }
    return self;
}
- (void)action:(UIView *)sender {}
@end

@implementation LYSDateHeadrView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)setBackgroundHexColor:(NSString *)backgroundHexColor
{
    _backgroundHexColor = backgroundHexColor;
    self.backgroundColor = [self colorWithHex:_backgroundHexColor];
}

// 颜色格式的转换
- (UIColor *)colorWithHex:(NSString *)hexColor{
    // 去除字符串两边的空格
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {return nil;}
    if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}
    NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];
    NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];
    NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g ,b , a;
    [[NSScanner scannerWithString:red] scanHexInt:&r];
    [[NSScanner scannerWithString:green] scanHexInt:&g];
    [[NSScanner scannerWithString:blue] scanHexInt:&b];
    if ([hexColor length] == 8) {
        NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    }else {
        a = 255;
    }
    return [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];
}

- (void)setHeaderBar:(LYSDateHeaderBar *)headerBar
{
    _headerBar = headerBar;
    NSArray *arr = [NSArray arrayWithArray:self.subviews];
    for (int i = 0; i < [arr count]; i++) {
        UIView *view = [arr objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    if (_headerBar.titleView && _headerBar.title) {
        [self createTitleView];
    } else {
        Match(_headerBar.title,                                                                             {[self createTitle];})
        Match(_headerBar.titleView,                                                                         {[self createTitleView];})
    }
    
    if (_headerBar.leftBarItem && _headerBar.leftBarItems && [_headerBar.leftBarItems count]) {
        [self createLeftMoreItem];
    } else {
        Match(_headerBar.leftBarItem,                                                                       {[self createLeftSingleItem];})
        Match(_headerBar.leftBarItems && [_headerBar.leftBarItems count],                                   {[self createLeftMoreItem];})
    }
    
    if (_headerBar.rightBarItem && _headerBar.rightBarItems && [_headerBar.rightBarItems count]) {
        [self createRightMoreItem];
    } else {
        Match(_headerBar.rightBarItem,                                                                      {[self createRightSingleItem];})
        Match(_headerBar.rightBarItems && [_headerBar.rightBarItems count],                                 {[self createRightMoreItem];})
    }
}

- (void)createTitle
{
    UILabel *label = [[UILabel alloc] init];
    label.text = _headerBar.title;
    label.textColor = _headerBar.titleColor;
    label.font = _headerBar.titleFont;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    [self addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    Layout(label, CenterX, Equal, self, CenterX, 1.0f, 0).active = YES;
    Layout(label, CenterY, Equal, self, CenterY, 1.0f, 0).active = YES;
}

- (void)createTitleView
{
    [self addSubview:_headerBar.titleView];
    _headerBar.titleView.translatesAutoresizingMaskIntoConstraints = NO;
    Layout(_headerBar.titleView, CenterX, Equal, self, CenterX, 1.0f, 0).active = YES;
    Layout(_headerBar.titleView, CenterY, Equal, self, CenterY, 1.0f, 0).active = YES;
}

- (void)createLeftSingleItem
{
    UIView *itemView = [self transitionWithBarItem:_headerBar.leftBarItem];
    [self addSubview:itemView];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    Layout(itemView, Left, Equal, self, Left, 1.0f, 5).active = YES;
    Layout(itemView, Top, Equal, self, Top, 1.0f, 0).active = YES;
    Layout(itemView, Bottom, Equal, self, Bottom, 1.0f, 0).active = YES;
    UIView *subView = [[itemView subviews] objectAtIndex:0];
    Layout(itemView, Width, Equal, subView, Width, 1.0f, 10).active = YES;
}

- (void)createLeftMoreItem
{
    UIView *leftView = nil;
    for (int i = 0; i < [_headerBar.leftBarItems count]; i++) {
        LYSDateHeaderBarItem *item = [_headerBar.leftBarItems objectAtIndex:i];
        UIView *itemView = [self transitionWithBarItem:item];
        [self addSubview:itemView];
        itemView.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(itemView, Top, Equal, self, Top, 1.0f, 0).active = YES;
        Layout(itemView, Bottom, Equal, self, Bottom, 1.0f, 0).active = YES;
        UIView *subView = [[itemView subviews] objectAtIndex:0];
        Layout(itemView, Width, Equal, subView, Width, 1.0f, 10).active = YES;
        if (i == 0) {
            Layout(itemView, Left, Equal, self, Left, 1.0f, 5).active = YES;
        } else {
            Layout(itemView, Left, Equal, leftView, Right, 1.0f, 5).active = YES;
        }
        leftView = itemView;
    }
}

- (void)createRightSingleItem
{
    UIView *itemView = [self transitionWithBarItem:_headerBar.rightBarItem];
    [self addSubview:itemView];
    itemView.translatesAutoresizingMaskIntoConstraints = NO;
    Layout(itemView, Right, Equal, self, Right, 1.0f, -5).active = YES;
    Layout(itemView, Top, Equal, self, Top, 1.0f, 0).active = YES;
    Layout(itemView, Bottom, Equal, self, Bottom, 1.0f, 0).active = YES;
    UIView *subView = [[itemView subviews] objectAtIndex:0];
    Layout(itemView, Width, Equal, subView, Width, 1.0f, 10).active = YES;
}

- (void)createRightMoreItem
{
    UIView *rightView = nil;
    for (int i = 0; i < [_headerBar.rightBarItems count]; i++) {
        LYSDateHeaderBarItem *item = [_headerBar.rightBarItems objectAtIndex:i];
        UIView *itemView = [self transitionWithBarItem:item];
        [self addSubview:itemView];
        itemView.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(itemView, Top, Equal, self, Top, 1.0f, 0).active = YES;
        Layout(itemView, Bottom, Equal, self, Bottom, 1.0f, 0).active = YES;
        UIView *subView = [[itemView subviews] objectAtIndex:0];
        Layout(itemView, Width, Equal, subView, Width, 1.0f, 10).active = YES;
        if (i == 0) {
            Layout(itemView, Right, Equal, self, Right, 1.0f, -5).active = YES;
        } else {
            Layout(itemView, Right, Equal, rightView, Left, 1.0f, -5).active = YES;
        }
        rightView = itemView;
    }
}

- (UIView *)transitionWithBarItem:(LYSDateHeaderBarItem *)item
{
    LYSDateHeaderBarContent *contentView = [[LYSDateHeaderBarContent alloc] init];
    Match(item.type == LYSDateHeaderBarItemTypeTitle, {
        UILabel *label = [[UILabel alloc] init];
        label.text = item.title;
        label.textColor = item.tintColor;
        label.font = item.font;
        [label sizeToFit];
        [contentView addSubview:label];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(label, CenterX,    Equal, contentView,  CenterX,            1.0f, 0).active = YES;
        Layout(label, CenterY,   Equal, contentView,  CenterY,           1.0f, 0).active = YES;
        objc_setAssociatedObject(contentView, @"item", item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [contentView addGestureRecognizer:tap];
    })
    Match(item.type == LYSDateHeaderBarItemTypeImage, {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = item.image;
        [contentView addSubview:imageView];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(imageView, CenterX,    Equal, contentView,  CenterX,            1.0f, 0).active = YES;
        Layout(imageView, CenterY,   Equal, contentView,  CenterY,           1.0f, 0).active = YES;
        Layout(imageView, Width,   Equal, nil,  NotAnAttribute,           1.0f, 25).active = YES;
        Layout(imageView, Height,   Equal, nil,  NotAnAttribute,           1.0f, 25).active = YES;
        objc_setAssociatedObject(contentView, @"item", item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [contentView addGestureRecognizer:tap];
    })
    Match(item.type == LYSDateHeaderBarItemTypeCustom, {
        [contentView addSubview:item.customView];
        item.customView.translatesAutoresizingMaskIntoConstraints = NO;
        Layout(item.customView, CenterX,    Equal, contentView,  CenterX,            1.0f, 0).active = YES;
        Layout(item.customView, CenterY,   Equal, contentView,  CenterY,           1.0f, 0).active = YES;
        Layout(item.customView, Width,   Equal, contentView,  Width,           1.0f, 25).active = YES;
        Layout(item.customView, Height,   Equal, contentView,  Height,           1.0f, 25).active = YES;
    })
    return contentView;
}

- (void)clickAction:(UITapGestureRecognizer *)sender
{
    LYSDateHeaderBarItem *item = objc_getAssociatedObject(sender.view, @"item");
    [item.invocation invoke];
}
@end

@implementation LYSDateHeaderBarContent
- (void)dealloc
{
    objc_removeAssociatedObjects(self);
}
@end
