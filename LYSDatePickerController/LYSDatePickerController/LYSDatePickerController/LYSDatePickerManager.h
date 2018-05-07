//
//  LYSDatePickerManager.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/3.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSDatePickerManager : NSObject
// 获取年列表
- (NSArray<NSString *> *)fetchYearsWithFromYear:(int)fromYear to:(int)toYear;
// 获取月列表
- (NSArray<NSString *> *)fetchMonthsWithYear:(int)year;
// 获取天列表(不包含星期几)
- (NSArray<NSString *> *)fetchDaysWithYear:(int)year month:(int)month;
// 获取日列表(包含星期几)
- (NSArray<NSString *> *)fetchDaysAndWeekDayWithYear:(int)year month:(int)month isShortWeekName:(BOOL)isShortName identifier:(NSString *)identifier;
// 获取小时
- (NSArray<NSString *> *)fetchHour;
// 获取分钟
- (NSArray<NSString *> *)fetchMinutes;
// 获取给定日期所在的月有多少天
- (NSUInteger)fetchDaysOfMonthWithDate:(NSDate *)date;
// 获取给定日期所在的年有多少天
- (NSUInteger)fecthDaysOfYearWithDate:(NSDate *)date;
// 获取给定日期所在月第一天的日期
- (NSDate *)fetchFirstDayOfMonthWithDate:(NSDate *)date;
// 获取给定日期所在月最后一天的日期
- (NSDate *)fetchLastDayOfMonthWithDate:(NSDate *)date;
// 获取给定日期是星期几
- (NSInteger)fetchWeekdayNumWithDate:(NSDate *)date;
// 获取给定日期是星期几
- (NSString *)fetchWeekdayNameWithDate:(NSDate *)date isShortName:(BOOL)isShortName localeIdentifier:(NSString *)localeIdentifier;
// 获取给定日期是星期几
- (NSString *)fetchWeekdayCNNameWithDate:(NSDate *)date isShortName:(BOOL)isShortName;
// 获取给定日期是星期几
- (NSString *)fetchWeekdayENNameWithDate:(NSDate *)date isShortName:(BOOL)isShortName;
@end
