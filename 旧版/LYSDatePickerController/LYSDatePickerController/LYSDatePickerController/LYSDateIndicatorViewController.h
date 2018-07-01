//
//  LYSDateIndicatorViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateHeaderViewController.h"

@interface LYSDateIndicatorViewController : LYSDateHeaderViewController
// 是否显示分割线
@property (nonatomic,assign)BOOL showIndicator;
// 分割线颜色
@property (nonatomic,strong)UIColor *indicatorColor;
// 分割线高度
@property(nonatomic, assign)CGFloat indicatorHeight;
@end
