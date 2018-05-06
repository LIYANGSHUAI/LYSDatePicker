//
//  LYSDatePickerHeaderView.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYSDatePickerItem.h"

@class LYSDateHeaderViewController;

@protocol LYSDatePickerHeaderViewProtocol <NSObject>

- (void)updateDate:(NSDate *)date;

@end

@interface LYSDatePickerHeaderView : UIView<LYSDatePickerHeaderViewProtocol>

@property(nonatomic, weak)LYSDateHeaderViewController *headerVC;

@property(nonatomic, strong)LYSDatePickerItem *leftItem;
@property(nonatomic, strong)LYSDatePickerItem *rightItem;
@property(nonatomic, strong)LYSDatePickerItem *centerItem;

@property(nonatomic, assign)BOOL showTimeLabel;
@property(nonatomic, strong)LYSDatePickerItem *tileLabelItem;

@property(nonatomic, assign)CGFloat headerHeight;

@end
