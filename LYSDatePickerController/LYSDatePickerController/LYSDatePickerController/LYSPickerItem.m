//
//  LYSPickerItem.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSPickerItem.h"

@interface LYSPickerItem ()

@property (nonatomic,strong)NSInvocation *invocation;

@end

@implementation LYSPickerItem

- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    if (self = [super init]) {
        self.btn = [[UIButton alloc] init];
        [self.btn setTitle:title forState:(UIControlStateNormal)];
        [self.btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:action]];
        [self.invocation setSelector:action];
        [self.invocation setTarget:target];
        // 从2开始是因为前两个参数已经被selector和target占用
        [self.invocation setArgument:&self atIndex:2];
    }
    return self;
}
- (void)btnAction {
    [_invocation invoke];
}
@end
