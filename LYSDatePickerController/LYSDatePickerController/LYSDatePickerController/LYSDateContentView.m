//
//  LYSDateContentView.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/5.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDateContentView.h"

#define Rect(x,y,w,h) CGRectMake(x, y, w, h)
#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@implementation LYSDateContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 0);
    }
    return self;
}

- (void)refreshContentHeight
{
    CGFloat height = 0;
    for (UIView *view in self.subviews) {
        height += CGRectGetHeight(view.frame);
    }
    CGRect contentFrame = self.frame;
    contentFrame.size.height = height;
    self.frame = contentFrame;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
