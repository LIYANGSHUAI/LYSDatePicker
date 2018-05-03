//
//  ViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSDatePickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 100, 40)];
    btn1.backgroundColor = [UIColor redColor];
    btn1.titleLabel.textColor = [UIColor whiteColor];
    [btn1 setTitle:@"按钮1" forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 40)];
    btn2.backgroundColor = [UIColor redColor];
    btn2.titleLabel.textColor = [UIColor whiteColor];
    [btn2 setTitle:@"按钮2" forState:(UIControlStateNormal)];
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(10, 300, 100, 40)];
    btn3.backgroundColor = [UIColor redColor];
    btn3.titleLabel.textColor = [UIColor whiteColor];
    [btn3 setTitle:@"按钮3" forState:(UIControlStateNormal)];
    [btn3 addTarget:self action:@selector(btn3Action) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn3];
}

- (void)btn1Action {
    [LYSDatePickerController alertDatePickerWithType:LYSDatePickerTypeDayAndTime];
}

- (void)btn2Action {
    [LYSDatePickerController alertDatePickerWithType:LYSDatePickerTypeDay];
}

- (void)btn3Action {
    [LYSDatePickerController alertDatePickerWithType:LYSDatePickerTypeTime];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
