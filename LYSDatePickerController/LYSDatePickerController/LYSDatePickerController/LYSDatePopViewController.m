//
//  LYSDatePopViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePopViewController.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth(self.view.frame)
#define ScreenHeight CGRectGetHeight(self.view.frame)

@interface LYSDatePopViewController ()

@property (nonatomic,strong,readwrite)LYSDateContentView *contentView;

@end

@implementation LYSDatePopViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    // 设置内容视图
    [self initContentView];
}

- (LYSDateContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[LYSDateContentView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

// 设置内容视图
- (void)initContentView
{
    [self.view addSubview:self.contentView];
}

// 动画显示contentView
- (void)showAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion
{
    [self.contentView refreshContentHeight];
    CGFloat contentHeight = CGRectGetHeight(self.contentView.frame);
    CGFloat tabHeight = [self superExistTab] ? 49 : 0;
    [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        self.contentView.frame = Rect(0, ScreenHeight - contentHeight - tabHeight, ScreenWidth, contentHeight);
    } completion:completion];
}

// 动画隐藏contentView
- (void)hiddenAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion
{
    [self.contentView refreshContentHeight];
    CGFloat contentHeight = CGRectGetHeight(self.contentView.frame);
    [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.contentView.frame = Rect(0, ScreenHeight, ScreenWidth, contentHeight);
    } completion:completion];
}

- (BOOL)superExistTab
{
    UIViewController *parentVC = self.presentingViewController;
    while (parentVC != nil && ![parentVC isKindOfClass:[UITabBarController class]]) {
        parentVC = parentVC.parentViewController;
    }
    return [parentVC isKindOfClass:[UITabBarController class]];
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
