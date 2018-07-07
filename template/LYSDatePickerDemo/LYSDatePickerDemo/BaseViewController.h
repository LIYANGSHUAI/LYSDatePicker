//
//  BaseViewController.h
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/6.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSDatePicker.h"

@interface BaseViewController : UIViewController<LYSDatePickerDelegate,LYSDatePickerDataSource>
@property (nonatomic, strong) LYSDateHeaderBar *headerBar;
@end
