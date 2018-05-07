//
//  LYSDateHeaderViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePopViewController.h"
#import "LYSDatePickerHeaderView.h"

@interface LYSDateHeaderViewController : LYSDatePopViewController
// 头视图高度,只有当headerView是默认创建的时候,才有效
@property (nonatomic,assign)CGFloat pickHeaderHeight;
// 选择器头视图,可以自定义
@property (nonatomic,strong)LYSDatePickerHeaderView *headerView;
@end
