//
//  LYSPickerItem.h
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSPickerItem : NSObject

@property (nonatomic,strong)UIButton *btn;

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end
