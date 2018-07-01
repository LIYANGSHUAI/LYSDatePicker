//
//  LYSDateBaseViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateBaseViewController.h"

NSString *const LYSDatePickerWillAppearNotifition = @"LYSDatePickerWillAppearNotifition";
NSString *const LYSDatePickerDidAppearNotifition = @"LYSDatePickerDidAppearNotifition";
NSString *const LYSDatePickerWillDisAppearNotifition = @"LYSDatePickerWillDisAppearNotifition";
NSString *const LYSDatePickerDidDisAppearNotifition = @"LYSDatePickerDidDisAppearNotifition";

NSString *const LYSDatePickerDidCancelNotifition = @"LYSDatePickerDidCancelNotifition";
NSString *const LYSDatePickerDidSelectDateNotifition = @"LYSDatePickerDidSelectDateNotifition";

@interface LYSDateBaseViewController ()

@end

static id datePicker = nil;

@implementation LYSDateBaseViewController

+ (instancetype)shareInstance
{
    if (!datePicker) {
        datePicker = [[[self class] alloc] init];
    }
    return datePicker;
}

+ (void)shareRelease
{
    datePicker = nil;
}

- (void)commitDatePicker
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidSelectDateNotifition
                                                        object:nil
                                                      userInfo:@{@"date":self.date}];
    if (self.didSelectDatePicker)
    {
        self.didSelectDatePicker(self.date);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewController:didSelectDate:)])
    {
        [self.delegate pickerViewController:(LYSDatePickerController *)self didSelectDate:self.date];
    }
    
}

- (void)cancelDatePicker {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerDidCancel:)]) {
        [self.delegate pickerViewControllerDidCancel:(LYSDatePickerController *)self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidCancelNotifition object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
