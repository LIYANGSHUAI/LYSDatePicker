//
//  LYSDatePickerTypeDayAndTimeDelegate.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerTypeDayAndTimeDelegate.h"
#import "LYSDatePickerLabel.h"

#define IS5SBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))
#define IS6SBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667))
#define IS6SPBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736))
#define ISXBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812))

#define WidthRank(A,B,C,D,E) (IS5SBOOL ? A : (IS6SBOOL ? B : (IS6SPBOOL ? C : (ISXBOOL ? D : E))))

@implementation LYSDatePickerTypeDayAndTimeDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return [self.years count] * (self.yearLoop ? 100 : 1);
        }
            break;
        case 1:
        {
            return [self.months count] * (self.monthLoop ? 100 : 1);
        }
            break;
        case 2:
        {
            return [self.days count] * (self.dayLoop ? 100 : 1);
        }
            break;
        case 3:
        {
            return [self.hours count] * (self.hourLoop ? 100 : 1);
        }
            break;
        case 4:
        {
            return [self.minutes count] * (self.minuteLoop ? 100 : 1);
        }
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return CGRectGetWidth(pickerView.frame) / WidthRank(5.5, 5.5, 5.5, 5.5, 5.5);
        }
            break;
        case 1:
        {
            return CGRectGetWidth(pickerView.frame) / WidthRank(7.0, 7.0, 7.0, 7.0, 7.0);
        }
            break;
        case 2:
        {
            if (self.showWeakDay && self.weakDayType == LYSDatePickerWeakDayTypeUSDefault) {
                return CGRectGetWidth(pickerView.frame) / WidthRank(3.0, 3.0, 3.0, 3.0, 3.0);
            } else {
                return CGRectGetWidth(pickerView.frame) / WidthRank(4.0, 4.0, 4.0, 4.0, 4.0);
            }
        }
            break;
        case 3:
        {
            return CGRectGetWidth(pickerView.frame) / WidthRank(7.0, 7.0, 7.0, 7.0, 7.0);
        }
            break;
        case 4:
        {
            return CGRectGetWidth(pickerView.frame) / WidthRank(7.0, 7.0, 7.0, 7.0, 7.0);
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    LYSDatePickerLabel *label = [LYSDatePickerLabel Label];
    label.textAlignment = self.titleLabel.textAlignment;
    label.backgroundColor = self.titleLabel.backgroundColor;
    label.font = self.titleLabel.font;
    label.textColor = self.titleLabel.textColor;
    switch (component) {
        case 0:
        {
            id str = [self.years objectAtIndex:(row % [[self years] count])];
            label.text = [NSString stringWithFormat:@"%@年",str];
        }
            break;
        case 1:
        {
            id str = [self.months objectAtIndex:(row % [[self months] count])];
            label.text = [NSString stringWithFormat:@"%@月",str];
        }
            break;
        case 2:
        {
            id str = [self.days objectAtIndex:(row % [[self days] count])];
            if (self.showWeakDay) {
                id week = @"";
                if (self.weakDayType == LYSDatePickerWeakDayTypeUSShort || self.weakDayType == LYSDatePickerWeakDayTypeCNShort) {
                    week = [self.weekDaysShortName objectAtIndex:(row % [[self weekDaysShortName] count])];
                }
                if (self.weakDayType == LYSDatePickerWeakDayTypeUSDefault || self.weakDayType == LYSDatePickerWeakDayTypeCNDefault) {
                    week = [self.weekDays objectAtIndex:(row % [[self weekDays] count])];
                }
                label.text = [NSString stringWithFormat:@"%@日 %@",str,week];
            }else {
                label.text = [NSString stringWithFormat:@"%@日",str];
            }
        }
            break;
        case 3:
        {
            id str = [self.hours objectAtIndex:(row % [[self hours] count])];
            label.text = [NSString stringWithFormat:@"%@时",str];
        }
            break;
        case 4:
        {
            id str = [self.minutes objectAtIndex:(row % [[self minutes] count])];
            label.text = [NSString stringWithFormat:@"%@分",str];
        }
            break;
        default:
            break;
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            self.currentYear = [[self.years objectAtIndex:(row % [[self years] count])] intValue];
            [pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            self.currentMonth = [[self.months objectAtIndex:(row % [[self months] count])] intValue];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            self.currentDay = [[self.days objectAtIndex:(row % [[self days] count])] intValue];
        }
            break;
        case 3:
        {
            self.currentHour = [[self.hours objectAtIndex:(row % [[self hours] count])] intValue];
        }
            break;
        case 4:
        {
            self.currentMinute = [[self.minutes objectAtIndex:(row % [[self minutes] count])] intValue];
        }
            break;
        default:
            break;
    }
    
    if (self.didSelectItem) {
        self.didSelectItem([self dateWithYear:self.currentYear month:self.currentMonth day:self.currentDay hour:self.currentHour minute:self.currentMinute]);
    }
}

- (NSDate *)dateWithYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
//        [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [comps setYear:year];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:0];
    return [gregorian dateFromComponents:comps];
}

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
    NSString *currentDate = [dateFormat stringFromDate:date];
    NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
    self.currentYear = [[currentDateAry objectAtIndex:0] intValue];
    self.currentMonth = [[currentDateAry objectAtIndex:1] intValue];
    self.currentDay = [[currentDateAry objectAtIndex:2] intValue];
    self.currentHour = [[currentDateAry objectAtIndex:3] intValue];
    self.currentMinute = [[currentDateAry objectAtIndex:4] intValue];
    if (self.didSelectItem) {
        self.didSelectItem([self dateWithYear:self.currentYear month:self.currentMonth day:self.currentDay hour:self.currentHour minute:self.currentMinute]);
    }
}

// 更新选择器
- (void)updateDatePicker {
    NSInteger yearIndex = self.currentYear - self.fromYear;
    NSInteger monthIndex = self.currentMonth - 1;
    NSInteger dayIndex = self.currentDay - 1;
    NSInteger hourIndex = self.currentHour;
    NSInteger minuteIndex = self.currentMinute;
    yearIndex = yearIndex > [self.years count] - 1 ? [self.years count] - 1 : yearIndex;
    monthIndex = monthIndex > [self.months count] - 1 ? [self.months count] - 1 : monthIndex;
    dayIndex = dayIndex > [self.days count] - 1 ? [self.days count] - 1 : dayIndex;
    hourIndex = hourIndex > [self.hours count] - 1 ? [self.hours count] - 1 : hourIndex;
    minuteIndex = minuteIndex > [self.minutes count] - 1 ? [self.minutes count] - 1 : minuteIndex;
    [self.pickView selectRow:yearIndex inComponent:0 animated:NO];
    [self.pickView selectRow:monthIndex inComponent:1 animated:NO];
    [self.pickView selectRow:dayIndex inComponent:2 animated:NO];
    [self.pickView selectRow:hourIndex inComponent:3 animated:NO];
    [self.pickView selectRow:minuteIndex inComponent:4 animated:NO];
}

@end
