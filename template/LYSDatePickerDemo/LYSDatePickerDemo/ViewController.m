//
//  ViewController.m
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"
#import "SixViewController.h"
#import "SevenViewController.h"
#import "EightViewController.h"
#import "NineViewController.h"
#import "TenViewController.h"
#import "ElevenViewController.h"
#import "TwelveViewController.h"
#import "ThirteenvewController.h"
#import "FifteenViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *titleAry;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.title = @"日期选择器";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"TitleAndVC" ofType:@"plist"];
    
    self.titleAry = [NSArray arrayWithContentsOfFile:filePath];
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [[self.titleAry objectAtIndex:indexPath.row] allKeys][0];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[self.titleAry objectAtIndex:indexPath.row] allValues][0];
    UIViewController *vc = [[NSClassFromString(str) alloc] init];
    vc.title = [[self.titleAry objectAtIndex:indexPath.row] allKeys][0];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
