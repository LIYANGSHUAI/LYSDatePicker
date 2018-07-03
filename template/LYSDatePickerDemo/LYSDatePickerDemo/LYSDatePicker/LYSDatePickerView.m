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

/// Parse an NSDate object to get basic information about the date
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
 
 @param date Incoming date
 @return the LYSPickerDate type
 */
LYSPickerDate transformFromDate(NSDate *date)
{
    LYSPickerDate lysDate;
    NSDateComponents *component = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitWeekday fromDate:date];
    lysDate.year = [component year];
    lysDate.month = [component month];
    lysDate.day = [component day];
    lysDate.hour = [component hour];
    lysDate.timeType = lysDate.hour <= 11 ? 0 : 1;
    lysDate.minute = [component minute];
    lysDate.week = [component weekday];
    return lysDate;
}

LYSPickerDate setPickerDateYear(LYSPickerDate date, NSInteger year)
{
    LYSPickerDate tempDate = date;
    tempDate.year = year;
    return tempDate;
}

LYSPickerDate setPickerDateMonth(LYSPickerDate date, NSInteger month)
{
    LYSPickerDate tempDate = date;
    tempDate.month = month;
    return tempDate;
}

LYSPickerDate setPickerDateDay(LYSPickerDate date, NSInteger day)
{
    LYSPickerDate tempDate = date;
    tempDate.day = day;
    return tempDate;
}

LYSPickerDate setPickerDateHour(LYSPickerDate date, NSInteger hour)
{
    LYSPickerDate tempDate = date;
    tempDate.hour = hour;
    return tempDate;
}

LYSPickerDate setPickerDateMinute(LYSPickerDate date, NSInteger minute)
{
    LYSPickerDate tempDate = date;
    tempDate.minute = minute;
    return tempDate;
}

#define Format(...) [NSString stringWithFormat:__VA_ARGS__]
#define Crossroads(judge,A,B) (judge ? (A) : (B))
#define Match(A,B) if (A) B

#define Type(A) (self.type == (A))
#define DatePickerMode(A) (self.datePickerMode == (A))
#define HourStandard(A) (self.hourStandard == (A))

//#define SwitchReturn(A,Arr)\
//{\
//id value = nil;\
//value = [Arr objectAtIndex:A];\
//value;\
//}

@interface LYSDatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong)  UIPickerView        *pickerView;
@property (nonatomic, strong)  UIDatePicker        *datePicker;
@property (nonatomic, assign)  LYSPickerDate       currentDate;
@property (nonatomic, assign)  NSInteger           dayNum;
@end

@implementation LYSDatePickerView

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
 didMoveToSuperview This method is a parent class method, the current view has been added to the parent view trigger, the purpose of component rendering in this method is mainly to prevent the component from modifying some properties after initialization, can not immediately render the problem
 */
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self additionSubViews];
}

#pragma mark - Set default value -
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
    self.hourStandard = LYSDatePickerStandardDefault;
}

#pragma mark - Add a subview -
- (void)additionSubViews
{
    [self applyHeaderView];
    Match(Type(LYSDatePickerTypeSystem), [self applySystemPicker];)
    Match(Type(LYSDatePickerTypeCustom), [self applyCustomPicker];)
}

/*
 In the case that enableShowHeader is YES, if the user does not set the headerView, but the headerHeight is not 0, this time, by default, a default top status bar LYSDateHeadrView is created.
 */
- (UIView<LYSDateHeaderViewProtocol> *)headerView
{
    if (!_headerView) {
        _headerView = [[LYSDateHeadrView alloc] init];
    }
    return _headerView;
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
    
    CGFloat height = Crossroads(self.enableShowHeader, self.headerHeight, 0);
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
    
    CGFloat height = Crossroads(self.enableShowHeader, self.headerHeight, 0);
    Layout(self.pickerView, Top,    Equal, self,  Top,            1.0f, height).active = YES;
    Layout(self.pickerView, Left,   Equal, self,  Left,           1.0f, 0).active = YES;
    Layout(self.pickerView, Right,  Equal, self,  Right,          1.0f, 0).active = YES;
    Layout(self.pickerView, Bottom, Equal, self,  Bottom,         1.0f, 0).active = YES;
    
    self.currentDate = transformFromDate(self.date);
    
    [self initCurrentDate];
}

- (void)initCurrentDate
{
    Match(DatePickerMode(LYSDatePickerModeTime), {
        NSInteger hourValue = 0;
        Match(HourStandard(LYSDatePickerStandard24Hour), {hourValue = self.currentDate.hour;})
        Match(HourStandard(LYSDatePickerStandard12Hour), {
            hourValue = Crossroads(self.currentDate.hour == 0, 23, (self.currentDate.hour - 1));
            [self judgeHourTypeWith:2];
        })
        [self.pickerView selectRow:hourValue inComponent:0 animated:YES];
        [self.pickerView selectRow:self.currentDate.minute inComponent:1 animated:YES];
    })
    
    Match(DatePickerMode(LYSDatePickerModeDate), {
        [self judgeLeapYearWith:1];
        [self.pickerView selectRow:self.currentDate.month-1 inComponent:0 animated:YES];
        [self.pickerView selectRow:self.currentDate.day-1 inComponent:1 animated:YES];
    })
    
    Match(DatePickerMode(LYSDatePickerModeDateAndTime), {
        NSInteger hourValue = 0;
        Match(HourStandard(LYSDatePickerStandard24Hour), {hourValue = self.currentDate.hour;})
        Match(HourStandard(LYSDatePickerStandard12Hour), {
            hourValue = Crossroads(self.currentDate.hour == 0, 23, (self.currentDate.hour - 1));
            [self judgeHourTypeWith:4];
        })
        [self judgeLeapYearWith:1];
        [self.pickerView selectRow:self.currentDate.month-1 inComponent:0 animated:YES];
        [self.pickerView selectRow:self.currentDate.day-1 inComponent:1 animated:YES];
        [self.pickerView selectRow:hourValue inComponent:2 animated:YES];
        [self.pickerView selectRow:self.currentDate.minute inComponent:3 animated:YES];
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDate), {
        [self judgeLeapYearWith:2];
        [self.pickerView selectRow:self.currentDate.year-self.fromYear-1 inComponent:0 animated:YES];
        [self.pickerView selectRow:self.currentDate.month-1 inComponent:1 animated:YES];
        [self.pickerView selectRow:self.currentDate.day-1 inComponent:2 animated:YES];
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDateAndTime), {
        NSInteger hourValue = 0;
        Match(HourStandard(LYSDatePickerStandard24Hour), {hourValue = self.currentDate.hour;})
        Match(HourStandard(LYSDatePickerStandard12Hour), {
            hourValue = Crossroads(self.currentDate.hour == 0, 23, (self.currentDate.hour - 1));
            [self judgeHourTypeWith:5];
        })
        [self judgeLeapYearWith:2];
        [self.pickerView selectRow:self.currentDate.year-self.fromYear-1 inComponent:0 animated:YES];
        [self.pickerView selectRow:self.currentDate.month-1 inComponent:1 animated:YES];
        [self.pickerView selectRow:self.currentDate.day-1 inComponent:2 animated:YES];
        [self.pickerView selectRow:hourValue inComponent:3 animated:YES];
        [self.pickerView selectRow:self.currentDate.minute inComponent:4 animated:YES];
    })
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    Match(DatePickerMode(LYSDatePickerModeTime), {return Crossroads(HourStandard(LYSDatePickerStandard12Hour), 3, 2);})
    Match(DatePickerMode(LYSDatePickerModeDate), {return 2;})
    Match(DatePickerMode(LYSDatePickerModeDateAndTime), {return Crossroads(HourStandard(LYSDatePickerStandard12Hour), 5, 4);})
    Match(DatePickerMode(LYSDatePickerModeYearAndDate), {return 3;})
    Match(DatePickerMode(LYSDatePickerModeYearAndDateAndTime), {return Crossroads(HourStandard(LYSDatePickerStandard12Hour), 6, 5);})
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    Match(DatePickerMode(LYSDatePickerModeTime), {
        Match(component == 0, {return 24;});
        Match(component == 1, {return 60;});
        Match(component == 2, {return 2;});
    })
    
    Match(DatePickerMode(LYSDatePickerModeDate), {
        Match(component == 0, {return 12;});
        Match(component == 1, {return self.dayNum;});
    })
    
    Match(DatePickerMode(LYSDatePickerModeDateAndTime), {
        Match(component == 0, {return 12;});
        Match(component == 1, {return self.dayNum;});
        Match(component == 2, {return 24;});
        Match(component == 3, {return 60;});
        Match(component == 4, {return 2;});
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDate), {
        Match(component == 0, {return self.toYear - self.fromYear;});
        Match(component == 1, {return 12;});
        Match(component == 2, {return self.dayNum;});
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDateAndTime), {
        Match(component == 0, {return self.toYear - self.fromYear;});
        Match(component == 1, {return 12;});
        Match(component == 2, {return self.dayNum;});
        Match(component == 3, {return 24;});
        Match(component == 4, {return 60;});
        Match(component == 5, {return 2;});
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
    label.backgroundColor = [UIColor redColor];
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    Match(DatePickerMode(LYSDatePickerModeTime), {
        Match(component == 0, {
            Match(HourStandard(LYSDatePickerStandard24Hour), {return Crossroads(row < 10, Format(@"0%ld",row), Format(@"%ld",row));})
            Match(HourStandard(LYSDatePickerStandard12Hour), {return Crossroads(row <= 11, Format(@"%ld",row + 1), Format(@"%ld",row + 1 - 12));})
        })
        Match(component == 1, {return Crossroads(row < 10, Format(@"0%ld",row), Format(@"%ld",row));})
        Match(component == 2, {return Crossroads(row == 0, @"AM", @"PM");})
    })
    
    Match(DatePickerMode(LYSDatePickerModeDate), {
        Match(component == 0, {return Format(@"%ld",row+1);})
        Match(component == 1, {return Format(@"%ld",row+1);})
    })
    
    Match(DatePickerMode(LYSDatePickerModeDateAndTime), {
        Match(component == 0, {return Format(@"%ld",row+1);})
        Match(component == 1, {return Format(@"%ld",row+1);})
        Match(component == 2, {
            Match(HourStandard(LYSDatePickerStandard24Hour), {return Crossroads(row < 10, Format(@"0%ld",row), Format(@"%ld",row));})
            Match(HourStandard(LYSDatePickerStandard12Hour), {return Crossroads(row <= 11, Format(@"%ld",row+1), Format(@"%ld",row+1-12));})
        })
        Match(component == 3, {return Crossroads(row < 10, Format(@"0%ld",row), Format(@"%ld",row));})
        Match(component == 4, {return row == 0 ? @"AM" : @"PM";})
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDate), {
        Match(component == 0, {return Format(@"%ld",self.fromYear + row+1);})
        Match(component == 1, {return Format(@"%ld",row+1);})
        Match(component == 2, {return Format(@"%ld",row+1);})
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDateAndTime), {
        Match(component == 0, {return Format(@"%ld",self.fromYear + row+1);})
        Match(component == 1, {return Format(@"%ld",row+1);})
        Match(component == 2, {return Format(@"%ld",row+1);})
        Match(component == 3, {
            Match(HourStandard(LYSDatePickerStandard24Hour), {return Crossroads(row < 10, Format(@"0%ld",row), Format(@"%ld",row));})
            Match(HourStandard(LYSDatePickerStandard12Hour), {return Crossroads(row <= 11, Format(@"%ld",row+1), Format(@"%ld",row+1-12));})
        })
        Match(component == 4, {return Crossroads(row < 10, Format(@"0%ld",row), Format(@"%ld",row));})
        Match(component == 5, {return row == 0 ? @"AM" : @"PM";})
    })
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    Match(DatePickerMode(LYSDatePickerModeTime), {
        Match(component == 0, {
            Match(HourStandard(LYSDatePickerStandard24Hour), {self.currentDate = setPickerDateHour(self.currentDate, row);});
            Match(HourStandard(LYSDatePickerStandard12Hour), {
                self.currentDate = setPickerDateHour(self.currentDate, row+1);
                [self judgeHourTypeWith:2];
            });
        })
        Match(component == 1, {self.currentDate = setPickerDateMinute(self.currentDate, row);})
        Match(component == 2, {[self judgeHourTypeWith:2];})
    })
    
    Match(DatePickerMode(LYSDatePickerModeDate), {
        Match(component == 0, {
            self.currentDate = setPickerDateMonth(self.currentDate, row+1);
            [self judgeLeapYearWith:1];
        })
        Match(component == 1, {self.currentDate = setPickerDateDay(self.currentDate, row+1);})
    })
    
    Match(DatePickerMode(LYSDatePickerModeDateAndTime), {
        Match(component == 0, {
            self.currentDate = setPickerDateMonth(self.currentDate, row+1);
            [self judgeLeapYearWith:1];
        })
        Match(component == 1, {self.currentDate = setPickerDateDay(self.currentDate, row+1);})
        Match(component == 2, {
            Match(HourStandard(LYSDatePickerStandard24Hour), {self.currentDate = setPickerDateHour(self.currentDate, row);});
            Match(HourStandard(LYSDatePickerStandard12Hour), {
                self.currentDate = setPickerDateHour(self.currentDate, row+1);
                [self judgeHourTypeWith:4];
            });
        })
        Match(component == 3, {self.currentDate = setPickerDateMinute(self.currentDate, row);})
        Match(component == 4, {[self judgeHourTypeWith:4];})
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDate), {
        Match(component == 0, {
            self.currentDate = setPickerDateYear(self.currentDate, self.fromYear + row + 1);
            [self judgeLeapYearWith:2];
        })
        Match(component == 1, {
            self.currentDate = setPickerDateMonth(self.currentDate, row+1);
            [self judgeLeapYearWith:2];
        })
        Match(component == 2, {self.currentDate = setPickerDateDay(self.currentDate, row+1);})
    })
    
    Match(DatePickerMode(LYSDatePickerModeYearAndDateAndTime), {
        Match(component == 0, {
            self.currentDate = setPickerDateYear(self.currentDate, self.fromYear + row + 1);
            [self judgeLeapYearWith:2];
        })
        Match(component == 1, {
            self.currentDate = setPickerDateMonth(self.currentDate, row+1);
            [self judgeLeapYearWith:2];
        })
        Match(component == 2, {self.currentDate = setPickerDateDay(self.currentDate, row+1);})
        Match(component == 3, {
            Match(HourStandard(LYSDatePickerStandard24Hour), {self.currentDate = setPickerDateHour(self.currentDate, row);});
            Match(HourStandard(LYSDatePickerStandard12Hour), {
                self.currentDate = setPickerDateHour(self.currentDate, row+1);
                [self judgeHourTypeWith:5];
            });
        })
        Match(component == 4, {self.currentDate = setPickerDateMinute(self.currentDate, row);})
        Match(component == 5, {[self judgeHourTypeWith:5];})
    })
    
    NSLog(@"%ld年%ld月%ld日 %ld时%ld分 %ld周 %ld",self.currentDate.year,self.currentDate.month,self.currentDate.day,self.currentDate.hour,
          self.currentDate.minute,self.currentDate.week,self.currentDate.timeType);
}

- (void)judgeHourTypeWith:(NSInteger)index
{
    if (self.currentDate.hour <= 11) {
        [self.pickerView selectRow:0 inComponent:index animated:YES];
    } else {
        [self.pickerView selectRow:1 inComponent:index animated:YES];
    }
}

- (void)judgeLeapYearWith:(NSInteger)index
{
    if ([@[@1,@3,@5,@7,@8,@10,@12] containsObject:@(self.currentDate.month)]) {
        self.dayNum = 31;
    }
    if ([@[@4,@6,@9,@11] containsObject:@(self.currentDate.month)]) {
        self.dayNum = 30;
    }
    if (self.currentDate.month == 2) {
        
        if (self.currentDate.year % 100 == 0) {
            if (self.currentDate.year % 400 == 0) {
                self.dayNum = 29;
            } else {
                self.dayNum = 28;
            }
        } else {
            if (self.currentDate.year % 4 == 0) {
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
