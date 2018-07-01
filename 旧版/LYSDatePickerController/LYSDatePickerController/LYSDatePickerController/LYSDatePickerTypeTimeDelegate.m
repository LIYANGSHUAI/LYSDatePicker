//
//  LYSDatePickerTypeTimeDelegate.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerTypeTimeDelegate.h"
#import "LYSDatePickerLabel.h"

#define IS5SBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))
#define IS6SBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667))
#define IS6SPBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736))
#define ISXBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812))

#define WidthRank(A,B,C,D,E) (IS5SBOOL ? A : (IS6SBOOL ? B : (IS6SPBOOL ? C : (ISXBOOL ? D : E))))

@implementation LYSDatePickerTypeTimeDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return [self.hours count] * (self.hourLoop ? 100 : 1);
        }
            break;
        case 1:
        {
            return [self.minutes count] * (self.minuteLoop ? 100 : 1);
        }
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return CGRectGetWidth(pickerView.frame) / WidthRank(5.5, 5.5, 5.5, 5.5, 5.5);
        }
            break;
        case 1:
        {
            return CGRectGetWidth(pickerView.frame) / WidthRank(5.5, 5.5, 5.5, 5.5, 5.5);
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    LYSDatePickerLabel *label = [LYSDatePickerLabel Label];
    label.textAlignment = self.titleLabel.textAlignment;
    label.backgroundColor = self.titleLabel.backgroundColor;
    label.font = self.titleLabel.font;
    label.textColor = self.titleLabel.textColor;
    switch (component) {
        case 0:
        {
            id str = [self.hours objectAtIndex:(row % [[self hours] count])];
            label.text = [NSString stringWithFormat:@"%@时",str];
        }
            break;
        case 1:
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
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            self.currentHour = [[self.hours objectAtIndex:(row % [[self hours] count])] intValue];
        }
            break;
        case 1:
        {
            self.currentMinute = [[self.minutes objectAtIndex:(row % [[self minutes] count])] intValue];
        }
            break;
        default:
            break;
    }
    if (self.didSelectItem) {
        self.didSelectItem([self dateWithHour:self.currentHour minute:self.currentMinute]);
    }
}

- (NSDate *)dateWithHour:(int)hour minute:(int)minute
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:[NSDate date]];
    //    [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [comps setHour:hour];
    [comps setMinute:minute];
    [comps setSecond:0];
    return [gregorian dateFromComponents:comps];
}

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH/mm"];
    NSString *currentDate = [dateFormat stringFromDate:date];
    NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
    self.currentHour = [[currentDateAry objectAtIndex:0] intValue];
    self.currentMinute = [[currentDateAry objectAtIndex:1] intValue];
    if (self.didSelectItem) {
        self.didSelectItem([self dateWithHour:self.currentHour minute:self.currentMinute]);
    }
}

// 更新选择器
- (void)updateDatePicker {
    NSInteger hourIndex = self.currentHour;
    NSInteger minuteIndex = self.currentMinute;
    hourIndex = hourIndex > [self.hours count] - 1 ? [self.hours count] - 1 : hourIndex;
    minuteIndex = minuteIndex > [self.minutes count] - 1 ? [self.minutes count] - 1 : minuteIndex;
    [self.pickView selectRow:hourIndex inComponent:0 animated:NO];
    [self.pickView selectRow:minuteIndex inComponent:1 animated:NO];
}
@end
