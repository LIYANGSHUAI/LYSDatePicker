//
//  ViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/2.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSDatePickerController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LYSDatePickerSelectDelegate>

@property(nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"日期选择器";
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:(UITableViewStyleGrouped)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView的代理方法 -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:identifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"年/月/日/时/分";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"时/分";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"年/月/日";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"年/月/日";
        }
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [LYSDatePickerController alertDatePickerInWindowRootVC];
            [LYSDatePickerController customPickerDelegate:self];
        }
            break;
        case 1:
        {
            [LYSDatePickerController alertDatePickerWithController:self type:(LYSDatePickerTypeDay)];
            [LYSDatePickerController customPickerDelegate:self];
        }
            break;
        case 2:
        {
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1000000];
            [LYSDatePickerController alertDatePickerWithController:self type:(LYSDatePickerTypeDayAndTime) selectDate:date];
            [LYSDatePickerController customPickerDelegate:self];
        }
            break;
        case 3:
        {
            LYSDatePickerController *datePicker = [[LYSDatePickerController alloc] init];
            datePicker.headerView.backgroundColor = [UIColor colorWithRed:84/255.0 green:150/255.0 blue:242/255.0 alpha:1];
            datePicker.indicatorHeight = 1;
            datePicker.delegate = self;
            datePicker.headerView.centerItem.textColor = [UIColor whiteColor];
            datePicker.headerView.leftItem.textColor = [UIColor whiteColor];
            datePicker.headerView.rightItem.textColor = [UIColor whiteColor];
            datePicker.pickHeaderHeight = 40;
            datePicker.pickType = LYSDatePickerTypeDay;
            datePicker.headerView.showTimeLabel = NO;
            [datePicker showDatePickerWithController:self];
        }
            break;
        default:
            break;
    }
}

- (void)pickerViewController:(LYSDatePickerController *)pickerVC didSelectDate:(NSDate *)date {
    NSDateFormatter *dateFomat = [[NSDateFormatter alloc] init];
    [dateFomat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];;
    NSString *str = [dateFomat stringFromDate:date];
    NSLog(@"%@",date);
    NSLog(@"选择器类型:%lu,选择时间:%@",(unsigned long)pickerVC.pickType,str);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
