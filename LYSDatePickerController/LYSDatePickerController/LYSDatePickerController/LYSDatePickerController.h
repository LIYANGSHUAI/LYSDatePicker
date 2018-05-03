//
//  LYSDatePickerController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LYSDatePickerTypeDay,
    LYSDatePickerTypeDayAndTime,
    LYSDatePickerTypeTime,
} LYSDatePickerType;

@interface LYSDatePickerController : UIViewController

@property (nonatomic,assign)CGFloat pickViewHeight;
@property (nonatomic,assign)int fromYear;
@property (nonatomic,assign)int toYear;

@property (nonatomic,strong)NSDate *selectDate;

@property (nonatomic,assign)LYSDatePickerType pickType;

- (void)showDatePickerAnimation;
- (void)hiddenDatePickerAnimation;
@end
