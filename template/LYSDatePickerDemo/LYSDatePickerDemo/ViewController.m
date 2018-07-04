//
//  ViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSDatePickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LYSDatePickerView *datePicker1 = [[LYSDatePickerView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 250) type:(LYSDatePickerTypeSystem)];

    [self.view addSubview:datePicker1];
    
    LYSDatePickerView *datePicker2 = [[LYSDatePickerView alloc] initWithFrame:CGRectMake(0, 270, CGRectGetWidth(self.view.frame), 250)type:(LYSDatePickerTypeCustom)];
    
    datePicker2.datePickerMode = LYSDatePickerModeYearAndDateAndTime;
    datePicker2.hourStandard = LYSDatePickerStandard12Hour;
//    datePicker2.date = nil;
//    datePicker2.AMStr = @"上午";
//    datePicker2.PMStr = @"下午";
    
    [self.view addSubview:datePicker2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
