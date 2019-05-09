//
//  BaseViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/6.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [self ly_colorWithHex:@"#eeeeee"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStyleDone) target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

    LYSDateHeaderBarItem *cancelItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"取消" target:self action:@selector(cancelAction:)];

    cancelItem.tintColor = [UIColor whiteColor];
    
    LYSDateHeaderBarItem *commitItem = [[LYSDateHeaderBarItem alloc] initWithTitle:@"确定" target:self action:@selector(commitAction:)];
    
    commitItem.tintColor = [UIColor whiteColor];

    self.headerBar = [[LYSDateHeaderBar alloc] init];
    self.headerBar.leftBarItem = cancelItem;
    self.headerBar.rightBarItem = commitItem;
    self.headerBar.title = @"日期选择器";
    
    self.headerBar.titleColor = [UIColor whiteColor];
    
}

- (void)cancelAction:(LYSDateHeaderBarItem *)sender
{
    NSLog(@"取消");
}

- (void)commitAction:(LYSDateHeaderBarItem *)sender
{
    NSLog(@"确定");
}

- (void)datePicker:(LYSDatePicker *)pickerView didSelectDate:(NSDate *)date
{
    NSLog(@"%@",pickerView.date);
    NSLog(@"%@",date);
}

// 颜色格式的转换
- (UIColor *)ly_colorWithHex:(NSString *)hexColor{
    // 去除字符串两边的空格
    hexColor = [hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([hexColor length] < 6) {return nil;}
    if ([hexColor hasPrefix:@"#"]) {hexColor = [hexColor substringFromIndex:1];}
    NSString *red = [hexColor substringWithRange:NSMakeRange(0, 2)];
    NSString *green = [hexColor substringWithRange:NSMakeRange(2, 2)];
    NSString *blue = [hexColor substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g ,b , a;
    [[NSScanner scannerWithString:red] scanHexInt:&r];
    [[NSScanner scannerWithString:green] scanHexInt:&g];
    [[NSScanner scannerWithString:blue] scanHexInt:&b];
    if ([hexColor length] == 8) {
        NSString *as = [hexColor substringWithRange:NSMakeRange(4, 2)];
        [[NSScanner scannerWithString:as] scanHexInt:&a];
    }else {
        a = 255;
    }
    return [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:(float)a / 255.0];
}


- (void)backAction:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    NSLog(@"释放");
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
