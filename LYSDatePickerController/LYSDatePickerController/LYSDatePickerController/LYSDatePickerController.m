//
//  LYSDatePickerController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerController.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth(self.view.frame)
#define ScreenHeight CGRectGetHeight(self.view.frame)

@interface LYSDatePickerController ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView *pickView;

@property (nonatomic,assign)int currentYear;
@property (nonatomic,assign)int currentMonth;
@property (nonatomic,assign)int currentDay;

@property (nonatomic,strong)NSCalendar *gregorian;

// 获取年列表
@property (nonatomic,assign)int year_from;
@property (nonatomic,assign)int year_to;
@property (nonatomic,strong)NSArray<NSNumber *> *years;

// 获取月列表
@property (nonatomic,assign)int month_year;
@property (nonatomic,strong)NSArray<NSNumber *> *months;

// 获取天列表
@property (nonatomic,assign)int day_year;
@property (nonatomic,assign)int day_month;
@property (nonatomic,strong)NSArray<NSNumber *> *days;

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

- (NSArray *)years {
    return [self fetchYearsWithFromYear:self.fromYear to:self.toYear];
}

- (NSArray *)months {
    return [self fetchMonthsWithYear:self.currentYear];
}

- (NSArray *)days {
    return [self fetchDaysWithYear:self.currentYear month:self.currentMonth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSubViews];
    [self defaultSelectItem];
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
        default:
            break;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor redColor];
    switch (component) {
        case 0:
        {
            id str = [self.years objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@",str];
        }
            break;
        case 1:
        {
            id str = [self.months objectAtIndex:row];
            label.text = [NSString stringWithFormat:@"%@",str];
        }
            break;
        case 2:
        {
            id str = [self.days objectAtIndex:row];
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
            [pickerView reloadComponent:1];
        }
            break;
        case 1:
        {
            self.currentMonth = [[self.months objectAtIndex:row] intValue];
            [pickerView reloadComponent:2];
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

// 默认选中当前日期
- (void)defaultSelectItem {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDate = [dateFormat stringFromDate:[NSDate date]];
    NSArray *currentDateAry = [currentDate componentsSeparatedByString:@"/"];
    self.currentYear = [[currentDateAry objectAtIndex:0] intValue];
    self.currentMonth = [[currentDateAry objectAtIndex:1] intValue];
    self.currentDay = [[currentDateAry objectAtIndex:2] intValue];
    NSInteger yearIndex = [self.years indexOfObject:@(self.currentYear)];
    NSInteger monthIndex = [self.months indexOfObject:@(self.currentMonth)];
    NSInteger dayIndex = [self.days indexOfObject:@(self.currentDay)];
    [self.pickView selectRow:yearIndex inComponent:0 animated:YES];
    [self.pickView selectRow:monthIndex inComponent:1 animated:YES];
    [self.pickView selectRow:dayIndex inComponent:2 animated:YES];
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

#pragma mark - 计算日期 -
- (NSCalendar *)gregorian
{
    if (!_gregorian) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _gregorian;
}

- (NSArray<NSNumber *> *)fetchYearsWithFromYear:(int)fromYear to:(int)toYear {
    if (!(
          _year_from == fromYear
          && _year_to == toYear
          && _years
          && [_years count] > 0
          ))
    {
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = fromYear; i <= toYear; i++) {
            [tempAry addObject:@(i)];
        }
        _year_from = fromYear;
        _year_to = toYear;
        _years = tempAry;
    }
    return _years;
}

- (NSArray<NSNumber *> *)fetchMonthsWithYear:(int)year {
    if (!(
          _month_year == year
          && _months
          && [_months count] > 0
          ))
    {
        NSString *dateStr = [NSString stringWithFormat:@"%@",@(year)];
        NSDate *tempDate = [self dateWithString:dateStr formatter:@"yyyy"];
        NSInteger length = [self.gregorian rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:tempDate].length;
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 1; i <= length; i++) {
            [tempAry addObject:@(i)];
        }
        _month_year= year;
        _months = tempAry;
    }
    return _months;
}

- (NSArray<NSNumber *> *)fetchDaysWithYear:(int)year month:(int)month {
    if (!(
          _day_year == year
          && _day_month == month
          && _days
          && [_days count] > 0
          ))
    {
        NSString *dateStr = [NSString stringWithFormat:@"%@-%@",@(year),@(month)];
        NSDate *tempDate = [self dateWithString:dateStr formatter:@"yyyy-MM"];
        NSInteger length = [self.gregorian rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:tempDate].length;
        NSMutableArray *tempAry = [NSMutableArray array];
        for (int i = 1; i <= length; i++) {
            [tempAry addObject:@(i)];
        }
        _day_year = year;
        _day_month = month;
        _days = tempAry;
    }
    return _days;
}

- (NSDate *)dateWithString:(NSString *)dateStr formatter:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formatStr;
    return [formatter dateFromString:dateStr];
}

- (void)dealloc {
    NSLog(@"释放");
}

@end
