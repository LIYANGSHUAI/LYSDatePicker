//
//  LYSDateLogicViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerViewController.h"

typedef enum : NSUInteger {
    LYSDatePickerTypeDay,
    LYSDatePickerTypeDayAndTime,
    LYSDatePickerTypeTime,
} LYSDatePickerType;

@interface LYSDateLogicViewController : LYSDatePickerViewController

// 日期开始时间
@property (nonatomic,assign)int fromYear;
// 日期结束时间
@property (nonatomic,assign)int toYear;
// 默认选中日期
@property (nonatomic,strong)NSDate *selectDate;
// 选择器类型
@property (nonatomic,assign)LYSDatePickerType pickType;

@end
