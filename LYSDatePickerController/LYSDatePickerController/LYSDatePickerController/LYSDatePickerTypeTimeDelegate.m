//
//  LYSDatePickerTypeTimeDelegate.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerTypeTimeDelegate.h"

@implementation LYSDatePickerTypeTimeDelegate

#pragma mark - UIPickerView代理方法 -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return [self.hours count];
        }
            break;
        case 1:
        {
            return [self.minutes count];
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
            return CGRectGetWidth(self.view.frame) / 3.0;
        }
            break;
        case 1:
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
            id str = [self.hours objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@时",str];
        }
            break;
        case 1:
        {
            id str = [self.minutes objectAtIndex:row];
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
            self.currentHour = [[self.hours objectAtIndex:row] intValue];
        }
            break;
        case 1:
        {
            self.currentMinute = [[self.minutes objectAtIndex:row] intValue];
        }
            break;
        default:
            break;
    }
    [self.pickView selectRow:0 inComponent:0 animated:NO];
    [self.pickView selectRow:0 inComponent:1 animated:NO];
    [pickerView reloadAllComponents];
    [self updateDatePicker];
}

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH/mm"];
    NSString *currentDate = [dateFormat stringFromDate:date];
    NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
    self.currentHour = [[currentDateAry objectAtIndex:0] intValue];
    self.currentMinute = [[currentDateAry objectAtIndex:1] intValue];
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
