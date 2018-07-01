//
//  LYSDatePickerViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateIndicatorViewController.h"

@interface LYSDatePickerViewController : LYSDateIndicatorViewController
// 选择器视图
@property (nonatomic,strong,readonly)UIPickerView *pickView;
// 选择器视图颜色
@property (nonatomic,assign)CGFloat pickViewHeight;

@end
