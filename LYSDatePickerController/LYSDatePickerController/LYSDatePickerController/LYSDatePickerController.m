//
//  LYSDatePickerController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerController.h"
#import "LYSDatePickerManager.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth(self.view.frame)
#define ScreenHeight CGRectGetHeight(self.view.frame)

@interface LYSDatePickerController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView *pickView;
@property (nonatomic,strong)LYSDatePickerManager *pickerManager;

@property (nonatomic,assign)int currentYear;
@property (nonatomic,assign)int currentMonth;
@property (nonatomic,assign)int currentDay;
@property (nonatomic,assign)int currentHour;
@property (nonatomic,assign)int currentMinute;

@property (nonatomic,strong)NSArray<NSString *> *years;
@property (nonatomic,strong)NSArray<NSString *> *months;
@property (nonatomic,strong)NSArray<NSString *> *days;
@property (nonatomic,strong)NSArray<NSString *> *weekDays;
@property (nonatomic,strong)NSArray<NSString *> *weekDaysShortName;
@property (nonatomic,strong)NSArray<NSString *> *hours;
@property (nonatomic,strong)NSArray<NSString *> *minutes;

@end

static LYSDatePickerController *datePicker = nil;

@implementation LYSDatePickerController
// 弹出日期选择器,附带类型
+ (void)alertDatePickerWithType:(LYSDatePickerType)pickerType {
    [self alertDatePickerWithType:pickerType selectDate:[NSDate date]];
}
// 弹出日期选择器,附带类型和默认选中日期
+ (void)alertDatePickerWithType:(LYSDatePickerType)pickerType selectDate:(NSDate *)selectDate {
    if (datePicker) {
        [datePicker hiddenDatePickerAnimation];
    }
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = selectDate;
    datePicker.pickType = pickerType;
    [datePicker showDatePickerAnimation];
}
// 设置视图高度
+ (void)customPickerViewHeight:(CGFloat)height {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.pickViewHeight = height;
}
// 设置开始年份
+ (void)customFromYear:(int)fromYear {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.fromYear = fromYear;
}
// 设置结束年份
+ (void)customToYear:(int)toYear {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.toYear = toYear;
}
// 设置默认选中日期
+ (void)customSelectDate:(NSDate *)date {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.selectDate = date;
}
// 设置弹出类型
+ (void)customPickerType:(LYSDatePickerType)type {
    LYSDatePickerController *datePicker = [LYSDatePickerController shareInstance];
    datePicker.pickType = type;
}
// 创建单例
+ (instancetype)shareInstance {
    if (!datePicker) {
        datePicker = [[LYSDatePickerController alloc] init];
    }
    return datePicker;
}
// 释放单例
+ (void)shareRelease {
    datePicker = nil;
}
// 初始化数据
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pickViewHeight = 250;
        self.fromYear = 1970;
        self.toYear = 2070;
        self.pickType = LYSDatePickerTypeDayAndTime;
        self.selectDate = [NSDate date];
    }
    return self;
}

- (NSArray<NSString *> *)years {
    return [self.pickerManager fetchYearsWithFromYear:self.fromYear to:self.toYear];
}

- (NSArray<NSString *> *)months {
    return [self.pickerManager fetchMonthsWithYear:self.currentYear];
}

- (NSArray<NSString *> *)days {
    return [self.pickerManager fetchDaysWithYear:self.currentYear month:self.currentMonth];
}

- (NSArray<NSString *> *)weekDays {
    return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:NO];
}

- (NSArray<NSString *> *)weekDaysShortName {
    return [self.pickerManager fetchDaysAndWeekDayWithYear:self.currentYear month:self.currentMonth isShortWeekName:YES];
}

- (NSArray<NSString *> *)hours {
    return [self.pickerManager fetchHour];
}

- (NSArray<NSString *> *)minutes {
    return [self.pickerManager fetchMinutes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self defaultWithDate:_selectDate];
    [self updateDatePicker];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerManager = [[LYSDatePickerManager alloc] init];
    [self customSubViews];
}

- (void)customSubViews {
    self.pickView = [[UIPickerView alloc] initWithFrame:Rect(0, ScreenHeight - self.pickViewHeight, ScreenWidth, self.pickViewHeight)];
    self.pickView.backgroundColor = [UIColor whiteColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    [self.view addSubview:self.pickView];
}

#pragma mark - UIPickerView代理方法 -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
            return 5;
        }
            break;
        case LYSDatePickerTypeDay:
        {
            return 3;
        }
            break;
        case LYSDatePickerTypeTime:
        {
            return 2;
        }
            break;
        default:
            break;
    }
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
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
                case 3:
                {
                    return [self.hours count];
                }
                    break;
                case 4:
                {
                    return [self.minutes count];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerTypeDay:
        {
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
        }
            break;
        case LYSDatePickerTypeTime:
        {
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
        }
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
            switch (component) {
                case 0:
                {
                    return CGRectGetWidth(self.view.frame) / 5.0;
                }
                    break;
                case 1:
                {
                    return CGRectGetWidth(self.view.frame) / 6.0;
                }
                    break;
                case 2:
                {
                    return CGRectGetWidth(self.view.frame) / 4.0;
                }
                    break;
                case 3:
                {
                    return CGRectGetWidth(self.view.frame) / 6.0;
                }
                    break;
                case 4:
                {
                    return CGRectGetWidth(self.view.frame) / 6.0;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerTypeDay:
        {
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
        }
            break;
        case LYSDatePickerTypeTime:
        {
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
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
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
                case 3:
                {
                    id str = [self.hours objectAtIndex:row];
                    label.text = [NSString stringWithFormat:@"%@时",str];
                }
                    break;
                case 4:
                {
                    id str = [self.minutes objectAtIndex:row];
                    label.text = [NSString stringWithFormat:@"%@分",str];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case LYSDatePickerTypeDay:
        {
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
        }
            break;
        case LYSDatePickerTypeTime:
        {
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
        }
            break;
        default:
            break;
    }
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
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
                case 3:
                {
                    self.currentHour = [[self.hours objectAtIndex:row] intValue];
                }
                    break;
                case 4:
                {
                    self.currentMinute = [[self.minutes objectAtIndex:row] intValue];
                }
                    break;
                default:
                    break;
            }
            [self.pickView selectRow:0 inComponent:0 animated:NO];
            [self.pickView selectRow:0 inComponent:1 animated:NO];
            [self.pickView selectRow:0 inComponent:2 animated:NO];
            [self.pickView selectRow:0 inComponent:3 animated:NO];
            [self.pickView selectRow:0 inComponent:4 animated:NO];
        }
            break;
        case LYSDatePickerTypeDay:
        {
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
        }
            break;
        case LYSDatePickerTypeTime:
        {
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
        }
            break;
        default:
            break;
    }
    [pickerView reloadAllComponents];
    [self updateDatePicker];
}

- (void)showDatePickerAnimation
{
    self.view.backgroundColor = [UIColor clearColor];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [[self ly_getOuterViewController] presentViewController:self animated:YES completion:^{
        
    }];
}

- (void)hiddenDatePickerAnimation
{
    [self dismissViewControllerAnimated:YES completion:^{
        datePicker = nil;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenDatePickerAnimation];
}

// 拆分日期对象,获取时间粒度
- (void)defaultWithDate:(NSDate *)date {
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy/MM/dd/HH/mm"];
            NSString *currentDate = [dateFormat stringFromDate:date];
            NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
            self.currentYear = [[currentDateAry objectAtIndex:0] intValue];
            self.currentMonth = [[currentDateAry objectAtIndex:1] intValue];
            self.currentDay = [[currentDateAry objectAtIndex:2] intValue];
            self.currentHour = [[currentDateAry objectAtIndex:3] intValue];
            self.currentMinute = [[currentDateAry objectAtIndex:4] intValue];
        }
            break;
        case LYSDatePickerTypeDay:
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy/MM/dd"];
            NSString *currentDate = [dateFormat stringFromDate:date];
            NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
            self.currentYear = [[currentDateAry objectAtIndex:0] intValue];
            self.currentMonth = [[currentDateAry objectAtIndex:1] intValue];
            self.currentDay = [[currentDateAry objectAtIndex:2] intValue];
        }
            break;
        case LYSDatePickerTypeTime:
        {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"HH/mm"];
            NSString *currentDate = [dateFormat stringFromDate:date];
            NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
            self.currentHour = [[currentDateAry objectAtIndex:0] intValue];
            self.currentMinute = [[currentDateAry objectAtIndex:1] intValue];
        }
            break;
        default:
            break;
    }
}

// 更新选择器
- (void)updateDatePicker {
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
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
            break;
        case LYSDatePickerTypeDay:
        {
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
            break;
        case LYSDatePickerTypeTime:
        {
            NSInteger hourIndex = self.currentHour;
            NSInteger minuteIndex = self.currentMinute;
            hourIndex = hourIndex > [self.hours count] - 1 ? [self.hours count] - 1 : hourIndex;
            minuteIndex = minuteIndex > [self.minutes count] - 1 ? [self.minutes count] - 1 : minuteIndex;
            [self.pickView selectRow:hourIndex inComponent:0 animated:NO];
            [self.pickView selectRow:minuteIndex inComponent:1 animated:NO];
        }
            break;
        default:
            break;
    }
}

// 获取最外层控制器
- (UIViewController *)ly_getOuterViewController
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    return keyWindow.rootViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"释放");
}

@end
