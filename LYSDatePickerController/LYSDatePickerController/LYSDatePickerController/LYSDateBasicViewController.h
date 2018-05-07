//
//  LYSDateBasicViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/7.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSDateBasicViewController : UIViewController
// 获取最外层控制器
+ (UIViewController *)windowRootViewController;
// 创建给定颜色和透明度的图片
- (UIImage *)imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;
@end
