//
//  LYSDateLogicViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateLogicViewController.h"

#define IS5SBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))
#define IS6SBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667))
#define IS6SPBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736))
#define ISXBOOL CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812))

#define FontRank(A,B,C,D,E) (IS5SBOOL ? A : (IS6SBOOL ? B : (IS6SPBOOL ? C : (ISXBOOL ? D : E))))

@interface LYSDateLogicViewController ()

@property (nonatomic,strong,readwrite)UILabel *subLabel;          // 选择器itemLabel
@property (nonatomic,strong)LYSDatePickerTypeBase *typeBase;      // 默认选择类型

@end

@implementation LYSDateLogicViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.fromYear = 1970;                                 // 默认开始年份
        self.toYear = 2070;                                   // 默认结束年份
        self.pickType = LYSDatePickerTypeDayAndTime;          // 默认选择器类型
        self.selectDate = [NSDate date];                      // 默认选中日期
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化选择器类型
    [self initPickerType];
    
    // 设置默认日期
    [self.typeBase defaultWithDate:self.selectDate];
    [self.typeBase updateDatePicker];
}

- (UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel = [[UILabel alloc] init];
        _subLabel.textAlignment = NSTextAlignmentCenter;
        _subLabel.textColor = [UIColor blackColor];
        _subLabel.font = [UIFont systemFontOfSize:FontRank(14,16,16,16,16)];
#ifdef DEBUG
//        _subLabel.backgroundColor = [UIColor redColor];
#endif
    }
    return _subLabel;
}

// 初始化选择器类型
- (void)initPickerType {
    
    switch (self.pickType) {
        case LYSDatePickerTypeDayAndTime:
        {
            self.typeBase = [[LYSDatePickerTypeDayAndTimeDelegate alloc] initWithPickerView:self.pickView];
        }
            break;
        case LYSDatePickerTypeDay:
        {
            self.typeBase = [[LYSDatePickerTypeDayDelegate alloc] initWithPickerView:self.pickView];
        }
            break;
        case LYSDatePickerTypeTime:
        {
            self.typeBase = [[LYSDatePickerTypeTimeDelegate alloc] initWithPickerView:self.pickView];
        }
            break;
        default:
            break;
    }
    
    self.typeBase.fromYear = self.fromYear;
    self.typeBase.toYear = self.toYear;
    self.typeBase.titleLabel = self.subLabel;
    
    self.typeBase.yearLoop = self.yearLoop;
    self.typeBase.monthLoop = self.monthLoop;
    self.typeBase.dayLoop = self.dayLoop;
    self.typeBase.hourLoop = self.hourLoop;
    self.typeBase.minuteLoop = self.minuteLoop;
    
    self.typeBase.showWeakDay = self.showWeakDay;
    self.typeBase.weakDayType = self.weakDayType;
    
    self.pickView.delegate = self.typeBase;
    self.pickView.dataSource = self.typeBase;
    
    __weak LYSDateLogicViewController *weakSelf = self;
    [self.typeBase setDidSelectItem:^(NSDate *date) {
        weakSelf.date = date;
        if ([weakSelf.headerView respondsToSelector:@selector(updateDate:)]) {
            [weakSelf.headerView updateDate:date];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
