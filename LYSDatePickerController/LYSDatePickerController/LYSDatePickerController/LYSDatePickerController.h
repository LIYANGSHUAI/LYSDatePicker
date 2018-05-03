//
//  LYSDatePickerController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSDatePickerController : UIViewController

@property (nonatomic,assign)CGFloat pickViewHeight;
@property (nonatomic,assign)int fromYear;
@property (nonatomic,assign)int toYear;

@property (nonatomic,strong)NSDate *selectDate;

- (void)showDatePickerAnimation;
- (void)hiddenDatePickerAnimation;
@end
