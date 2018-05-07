//
//  LYSDatePickerManager.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/3.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerManager.h"

@interface LYSDatePickerManager ()

@property (nonatomic,strong)NSCalendar *gregorian;
// 获取年列表
@property (nonatomic,assign)int year_from;
@property (nonatomic,assign)int year_to;
@property (nonatomic,strong)NSArray<NSString *> *years;

// 获取月列表
@property (nonatomic,assign)int month_year;
@property (nonatomic,strong)NSArray<NSString *> *months;

// 获取天列表(不包含星期几)
@property (nonatomic,assign)int day_year;
@property (nonatomic,assign)int day_month;
@property (nonatomic,strong)NSArray<NSString *> *days;

// 获取天列表(包含星期几)
@property (nonatomic,assign)int weekday_year;
@property (nonatomic,assign)int weekday_month;
@property (nonatomic,strong)NSArray<NSString *> *weekdays;

// 获取小时
@property (nonatomic,strong)NSArray<NSString *> *hours;

// 获取分钟
@property (nonatomic,strong)NSArray<NSString *> *minutes;
@end

@implementation LYSDatePickerManager

#pragma mark - 计算日期 -
- (NSCalendar *)gregorian
{
    if (!_gregorian) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _gregorian;
}
// 获取年列表
- (NSArray<NSString *> *)fetchYearsWithFromYear:(int)fromYear to:(int)toYear
{
    BOOL isCan = _year_from == fromYear && _year_to == toYear && _years && [_years count] > 0;
    if (!isCan) {
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = fromYear; i <= toYear; i++) {
            [tempAry addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _years = tempAry;_year_from = fromYear;_year_to = toYear;
    }
    return _years;
}
// 获取月列表
- (NSArray<NSString *> *)fetchMonthsWithYear:(int)year
{
    BOOL isCan = _month_year == year && _months && [_months count] > 0;
    if (!isCan) {
        NSDate *tempDate = [self dateWithString:[NSString stringWithFormat:@"%@",@(year)] formatter:@"yyyy"];
        NSInteger length = [self.gregorian rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:tempDate].length;
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 1; i <= length; i++) {
            [tempAry addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _months = tempAry;_month_year= year;
    }
    return _months;
}
// 获取日列表(不包含星期几)
- (NSArray<NSString *> *)fetchDaysWithYear:(int)year month:(int)month
{
    BOOL isCan = _day_year == year && _day_month == month && _days && [_days count] > 0;
    if (!isCan) {
        NSDate *tempDate = [self dateWithString:[NSString stringWithFormat:@"%@/%@",@(year),@(month)] formatter:@"yyyy/MM"];
        NSInteger length = [self.gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:tempDate].length;
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 1; i <= length; i++) {
            [tempAry addObject:[NSString stringWithFormat:@"%d",i]];
        }
        _days = tempAry;_day_month = month;_day_year = year;
    }
    return _days;
}

// 获取日列表(包含星期几)
- (NSArray<NSString *> *)fetchDaysAndWeekDayWithYear:(int)year month:(int)month isShortWeekName:(BOOL)isShortName identifier:(NSString *)identifier
{
    BOOL isCan = _weekday_year == year && _weekday_month == month && _weekdays && [_weekdays count] > 0;
    if (!isCan) {
        NSDate *tempDate = [self dateWithString:[NSString stringWithFormat:@"%@/%@",@(year),@(month)] formatter:@"yyyy/MM"];
        NSInteger length = [self.gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:tempDate].length;
        unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *comps = [self.gregorian components:unitFlags fromDate:tempDate];
        [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 1; i <= length; i++) {
            [comps setDay:i];
            NSString *str = @"";
            if ([identifier isEqualToString:@"zh_CN"]) {
                str = [self fetchWeekdayCNNameWithDate:[self.gregorian dateFromComponents:comps] isShortName:isShortName];
            }
            if ([identifier isEqualToString:@"en_US"]) {
                str = [self fetchWeekdayENNameWithDate:[self.gregorian dateFromComponents:comps] isShortName:isShortName];
            }
            [tempAry addObject:str];
        }
        _weekdays = tempAry;_weekday_month = month;_weekday_year = year;
    }
    return _weekdays;
}
// 获取小时
- (NSArray<NSString *> *)fetchHour
{
    BOOL isCan = _hours && [_hours count] > 0;
    if (!isCan) {
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 0; i <= 23; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            if (i < 10) {
                str = [NSString stringWithFormat:@"0%@",str];
            }
            [tempAry addObject:str];
        }
        _hours = tempAry;
    }
    return _hours;
}

// 获取分钟
- (NSArray<NSString *> *)fetchMinutes
{
    BOOL isCan = _minutes && [_minutes count] > 0;
    if (!isCan) {
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 0; i <= 59; i++) {
            NSString *str = [NSString stringWithFormat:@"%d",i];
            if (i < 10) {
                str = [NSString stringWithFormat:@"0%@",str];
            }
            [tempAry addObject:str];
        }
        _minutes = tempAry;
    }
    return _minutes;
}

- (NSDate *)dateWithString:(NSString *)dateStr formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter dateFromString:dateStr];
}
// 获取给定日期所在的月有多少天
- (NSUInteger)fetchDaysOfMonthWithDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
// 获取给定日期所在的年有多少天
- (NSUInteger)fecthDaysOfYearWithDate:(NSDate *)date
{
    NSUInteger days = 0;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitYear fromDate:date];
    for (NSUInteger i=1; i<=12; i++) {
        [comps setMonth:i];
        days += [self fetchDaysOfMonthWithDate:[gregorian dateFromComponents:comps]];
    }
    return days;
}
// 获取给定日期所在月第一天的日期
- (NSDate *)fetchFirstDayOfMonthWithDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // 使用UTC或GMT解决时区相差8小时的问题
    [comps setDay:1];
    return [gregorian dateFromComponents:comps];
}
// 获取给定日期所在月最后一天的日期
- (NSDate *)fetchLastDayOfMonthWithDate:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    [comps setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; // 使用UTC或GMT解决时区相差8小时的问题
    [comps setDay:[self fetchDaysOfMonthWithDate:date]];
    return [gregorian dateFromComponents:comps];
}
// 获取给定日期是星期几
- (NSInteger)fetchWeekdayNumWithDate:(NSDate *)date
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:date] weekday];
}
// 获取给定日期是星期几
- (NSString *)fetchWeekdayNameWithDate:(NSDate *)date isShortName:(BOOL)isShortName localeIdentifier:(NSString *)localeIdentifier
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
    formatter.dateFormat = isShortName ? @"EE" : @"EEEE";
    return [formatter stringFromDate:date];
}
// 获取给定日期是星期几
- (NSString *)fetchWeekdayCNNameWithDate:(NSDate *)date isShortName:(BOOL)isShortName
{
    return [self fetchWeekdayNameWithDate:date isShortName:isShortName localeIdentifier:@"zh_CN"];
}
// 获取给定日期是星期几
- (NSString *)fetchWeekdayENNameWithDate:(NSDate *)date isShortName:(BOOL)isShortName
{
    return [self fetchWeekdayNameWithDate:date isShortName:isShortName localeIdentifier:@"en_US"];
}
@end
