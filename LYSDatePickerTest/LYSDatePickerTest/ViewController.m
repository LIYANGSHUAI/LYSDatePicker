//
//  ViewController.m
//  LYSDatePickerTest
//
//  Created by liyangshuai on 2018/7/7.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSDatePicker.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LYSDatePicker*picker = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
    picker.datePickerMode = LYSDatePickerModeYearAndDateAndTime;
    [self.view addSubview:picker];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
