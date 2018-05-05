//
//  LYSDatePopViewController.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateBaseViewController.h"
#import "LYSDateContentView.h"

@interface LYSDatePopViewController : LYSDateBaseViewController

@property (nonatomic,strong,readonly)LYSDateContentView *contentView;

// 动画显示contentView
- (void)showAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion;
// 动画隐藏contentView
- (void)hiddenAnimationContentViewWithCompletion:(void(^)(BOOL finished))completion;

@end
