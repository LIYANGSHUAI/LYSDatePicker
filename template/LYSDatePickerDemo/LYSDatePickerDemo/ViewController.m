//
//  ViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "LYSDatePickerView.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LYSDatePickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"日期选择器";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"UITableViewCell"];
    LYSDatePickerView *pickerView = [[LYSDatePickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeSystem)];
    pickerView.dataSource = self;
    
    [cell.contentView addSubview:pickerView];
    return cell;
}

- (void)datePicker:(LYSDatePickerView *)pickerView didSelectDate:(NSDate *)date
{
    NSLog(@"%@",date);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 256;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
