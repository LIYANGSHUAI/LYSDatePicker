
//
//  OneViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/6.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "OneViewController.h"
#import "LYSDatePickerView.h"
@interface OneViewController ()<LYSDatePickerViewDelegate,LYSDatePickerViewDataSource>

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    LYSDatePickerView *pickerView = [[LYSDatePickerView alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeSystem)];
    pickerView.datePickerMode = LYSDatePickerModeTime;
    pickerView.date = [NSDate date];
    pickerView.headerView.headerBar = self.headerBar;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    
}

- (CGFloat)datePicker:(LYSDatePickerView *)pickerView componentWidthOfIndex:(NSInteger)index
{
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
