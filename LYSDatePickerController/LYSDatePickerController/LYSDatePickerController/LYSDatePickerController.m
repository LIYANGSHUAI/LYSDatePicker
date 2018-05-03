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

@implementation LYSDatePickerController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pickViewHeight = 300;
        self.fromYear = 1970;
        self.toYear = 2070;
        self.selectDate = [NSDate date];
    }
    return self;
}

- (void)setSelectDate:(NSDate *)selectDate {
    _selectDate = selectDate;
    [self defaultWithDate:_selectDate];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pickerManager = [[LYSDatePickerManager alloc] init];
    [self customSubViews];
    [self updateDatePicker];
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
    return 5;
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
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            return 70;
        }
            break;
        case 1:
        {
            return 60;
        }
            break;
        case 2:
        {
            return 100;
        }
            break;
        case 3:
        {
            return 100;
        }
            break;
        case 4:
        {
            return 100;
        }
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
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
            label.text = [NSString stringWithFormat:@"%@ %@",str,week];
        }
            break;
        case 3:
        {
            id str = [self.hours objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@",str];
        }
            break;
        case 4:
        {
            id str = [self.minutes objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@",str];
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
    [self.pickView selectRow:0 inComponent:0 animated:YES];
    [self.pickView selectRow:0 inComponent:1 animated:YES];
    [self.pickView selectRow:0 inComponent:2 animated:YES];
    [self.pickView selectRow:0 inComponent:3 animated:YES];
    [self.pickView selectRow:0 inComponent:4 animated:YES];
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
        
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hiddenDatePickerAnimation];
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
