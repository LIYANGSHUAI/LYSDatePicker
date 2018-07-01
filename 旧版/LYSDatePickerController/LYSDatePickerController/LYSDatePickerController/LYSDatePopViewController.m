//
//  LYSDatePopViewController.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePopViewController.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface LYSDatePopViewController ()

@property (nonatomic,strong,readwrite)LYSDateContentView *contentView;

@end

@implementation LYSDatePopViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.clickOuterHiddenEnable = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
//    self.view.alpha = 0;
    // 设置内容视图
    [self initContentView];
}

- (LYSDateContentView *)contentView
{
    if (!_contentView) {
        _contentView = [[LYSDateContentView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.shadowColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1].CGColor;
        _contentView.layer.shadowOffset = CGSizeMake(0, -3);
        _contentView.layer.shadowOpacity = 0.2;
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
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerWillAppearNotifition object:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerWillAppear:)]) {
        [self.delegate pickerViewControllerWillAppear:(LYSDatePickerController *)self];
    }
    [self.contentView refreshContentHeight];
    CGFloat contentHeight = CGRectGetHeight(self.contentView.frame);
    CGFloat tabHeight = [self superExistTab] ? 49 : 0;
    [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
//        self.view.alpha = 1;
        self.contentView.frame = Rect(0, ScreenHeight - contentHeight - tabHeight, ScreenWidth, contentHeight);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidAppearNotifition object:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerDidAppear:)]) {
            [self.delegate pickerViewControllerDidAppear:(LYSDatePickerController *)self];
        }
        if (completion) {
            completion(finished);
        }
    }];
}

// 动画隐藏contentView
- (void)hiddenAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerWillDisAppearNotifition object:nil];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerWillDisAppear:)]) {
        [self.delegate pickerViewControllerWillDisAppear:(LYSDatePickerController *)self];
    }
    [self.contentView refreshContentHeight];
    CGFloat contentHeight = CGRectGetHeight(self.contentView.frame);
    [UIView animateWithDuration:0.2 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
        self.view.alpha = 0;
        self.contentView.frame = Rect(0, ScreenHeight, ScreenWidth, contentHeight);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LYSDatePickerDidDisAppearNotifition object:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pickerViewControllerdidDisAppear:)]) {
            [self.delegate pickerViewControllerdidDisAppear:(LYSDatePickerController *)self];
        }
        if (completion) {
            completion(finished);
        }
    }];
}

// 弹出
- (void)showDatePickerWithController:(UIViewController *)controller {
    [controller presentViewController:self animated:NO completion:^{
        [self showAnimationContentViewWithCompletion:nil];
    }];
}

// 弹出
+ (void)showDatePickerWithController:(UIViewController *)controller {
    [controller presentViewController:[[self class] shareInstance] animated:NO completion:^{
        [[[self class] shareInstance] showAnimationContentViewWithCompletion:nil];
    }];
}

// 在UIWindow的根视图上弹出
- (void)showDatePickerInWindowRootVC {
    [[[self class] windowRootViewController] presentViewController:self animated:NO completion:^{
        [self showAnimationContentViewWithCompletion:nil];
    }];
}

// 在UIWindow的根视图上弹出
+ (void)showDatePickerInWindowRootVC {
    [[[self class] windowRootViewController] presentViewController:[[self class] shareInstance] animated:NO completion:^{
        [[[self class] shareInstance] showAnimationContentViewWithCompletion:nil];
    }];
}

// 隐藏
- (void)hiddenDatePicker {
    [self hiddenAnimationContentViewWithCompletion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            [[self class] shareRelease];
        }];
    }];
}

// 隐藏
+ (void)hiddenDatePicker {
    [[[self class] shareInstance] hiddenAnimationContentViewWithCompletion:^(BOOL finished) {
        [[[self class] shareInstance] dismissViewControllerAnimated:NO completion:^{
            [[self class] shareRelease];
        }];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.clickOuterHiddenEnable) {
        [self hiddenDatePicker];
    }
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

@end
