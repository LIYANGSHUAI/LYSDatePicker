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
    
    LYSDatePickerView *datePicker = [[LYSDatePickerView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 200)type:(LYSDatePickerTypeSystem)];
    
    [self.view addSubview:datePicker];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
