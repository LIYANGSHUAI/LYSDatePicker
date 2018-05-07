//
//  LYSDatePickerLabel.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/7.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerLabel.h"

@interface LYSDatePickerLabel ()

@end

static NSMutableArray *useingLabelAry = nil;
static NSMutableArray *spareLabelAry = nil;

static int num = 0;

@implementation LYSDatePickerLabel

+ (instancetype)Label
{
    if (!useingLabelAry) {
        useingLabelAry = [NSMutableArray array];
    }
    
    if (!spareLabelAry) {
        spareLabelAry = [NSMutableArray array];
    }
    
    if ([spareLabelAry count] > 0) {
        LYSDatePickerLabel *label = [spareLabelAry lastObject];
        [useingLabelAry addObject:label];
        [spareLabelAry removeObject:label];
        label.frame = CGRectZero;
        return label;
    } else {
        NSLog(@"创建");
        num++;
        LYSDatePickerLabel *label = [[LYSDatePickerLabel alloc] init];
        [useingLabelAry addObject:label];
        return label;
    }

}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [spareLabelAry addObject:self];
        [useingLabelAry removeObject:self];
    }
    NSLog(@"创建了:%d个label",num);
//    NSLog(@"线上:%@",useingLabelAry);
//    NSLog(@"后备:%@",spareLabelAry);
}

- (void)dealloc {
    NSLog(@"释放lablel");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
