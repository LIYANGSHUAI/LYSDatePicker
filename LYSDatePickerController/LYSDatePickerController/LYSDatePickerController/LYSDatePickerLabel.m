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
    if (useingLabelAry.count == 0) {
        useingLabelAry = nil;
        spareLabelAry = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
