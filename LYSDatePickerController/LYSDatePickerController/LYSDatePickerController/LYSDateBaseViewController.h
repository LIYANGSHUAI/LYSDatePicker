//
//  LYSDateBaseViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSDateBaseViewController : UIViewController
// 获取最外层控制器
+ (UIViewController *)ly_getOuterViewController;
// 创建给定颜色和透明度的图片
- (UIImage *)ly_imageWithColor:(UIColor *)color alpha:(CGFloat)alpha;
@end
