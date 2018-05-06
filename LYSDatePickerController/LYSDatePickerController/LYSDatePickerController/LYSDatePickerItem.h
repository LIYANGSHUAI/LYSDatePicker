//
//  LYSDatePickerItem.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSDatePickerItem : NSObject

@property (nonatomic,strong,readonly)UIView *itemView;

@property(nonatomic, strong)UIFont *itemFont;
@property(nonatomic, strong)UIColor *textColor;
@property(nonatomic, strong)NSString *title;

+ (instancetype)btnWithTitle:(NSString *)title target:(id)target action:(SEL)action;
- (instancetype)initBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)labelWithTitle:(NSString *)title;
- (instancetype)initLabelWithTitle:(NSString *)title;

- (void)updateSize;
@end
