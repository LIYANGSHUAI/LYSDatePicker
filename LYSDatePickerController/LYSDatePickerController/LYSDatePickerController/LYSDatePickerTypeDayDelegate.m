//
//  LYSDatePickerTypeDayDelegate.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerTypeDayDelegate.h"

@implementation LYSDatePickerTypeDayDelegate

#pragma mark - UIPickerView代理方法 -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return [self.years count];
        }
            break;
        case 1:
        {
            return [self.months count];
        }
            break;
        case 2:
        {
            return [self.days count];
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
            return CGRectGetWidth(self.view.frame) / 4.0;
        }
            break;
        case 1:
        {
            return CGRectGetWidth(self.view.frame) / 5.0;
        }
            break;
        case 2:
        {
            return CGRectGetWidth(self.view.frame) / 3.0;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    switch (component) {
        case 0:
        {
            id str = [self.years objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@年",str];
        }
            break;
        case 1:
        {
            id str = [self.months objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@月",str];
        }
            break;
        case 2:
        {
            id str = [self.days objectAtIndex:row];
            id week = [self.weekDays objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@日 %@",str,week];
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
            self.currentYear = [[self.years objectAtIndex:row] intValue];
        }
            break;
        case 1:
        {
            self.currentMonth = [[self.months objectAtIndex:row] intValue];
        }
            break;
        case 2:
        {
            self.currentDay = [[self.days objectAtIndex:row] intValue];
        }
            break;
        default:
            break;
    }
    [self.pickView selectRow:0 inComponent:0 animated:NO];
    [self.pickView selectRow:0 inComponent:1 animated:NO];
    [self.pickView selectRow:0 inComponent:2 animated:NO];
    [pickerView reloadAllComponents];
    [self updateDatePicker];
}

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDate = [dateFormat stringFromDate:date];
    NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
    self.currentYear = [[currentDateAry objectAtIndex:0] intValue];
    self.currentMonth = [[currentDateAry objectAtIndex:1] intValue];
    self.currentDay = [[currentDateAry objectAtIndex:2] intValue];
}

// 更新选择器
- (void)updateDatePicker {
    NSInteger yearIndex = self.currentYear - self.fromYear;
    NSInteger monthIndex = self.currentMonth - 1;
    NSInteger dayIndex = self.currentDay - 1;
    yearIndex = yearIndex > [self.years count] - 1 ? [self.years count] - 1 : yearIndex;
    monthIndex = monthIndex > [self.months count] - 1 ? [self.months count] - 1 : monthIndex;
    dayIndex = dayIndex > [self.days count] - 1 ? [self.days count] - 1 : dayIndex;
    [self.pickView selectRow:yearIndex inComponent:0 animated:NO];
    [self.pickView selectRow:monthIndex inComponent:1 animated:NO];
    [self.pickView selectRow:dayIndex inComponent:2 animated:NO];
}
@end
