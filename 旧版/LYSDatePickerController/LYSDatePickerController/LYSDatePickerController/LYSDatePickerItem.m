//
//  LYSDatePickerItem.m
//  LYSDatePickerController
//
//  Created by HENAN on 2018/5/4.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import "LYSDatePickerItem.h"

@interface LYSDatePickerItem ()

@property (nonatomic,strong)NSInvocation *invocation;
@property (nonatomic,strong,readwrite)UIView *itemView;

@end

@implementation LYSDatePickerItem

@synthesize textColor = _textColor;
@synthesize itemFont = _itemFont;
@synthesize title = _title;

+ (instancetype)btnWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[LYSDatePickerItem alloc] initBtnWithTitle:title target:target action:action];
}

+ (instancetype)labelWithTitle:(NSString *)title
{
    return [[LYSDatePickerItem alloc] initLabelWithTitle:title];
}

- (instancetype)initBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:title forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(btnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:action]];
        [self.invocation setSelector:action];
        [self.invocation setTarget:target];
        // 从2开始是因为前两个参数已经被selector和target占用
        [self.invocation setArgument:&self atIndex:2];
        self.itemView =  btn;
    }
    return self;
}

- (instancetype)initLabelWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = title;
        self.itemView =  label;
    }
    return self;
}

- (void)btnAction {
    [_invocation invoke];
}

- (void)updateSize
{
    CGRect frame = self.itemView.frame;
    frame.size = [self sizeWithTitle:self.title font:self.itemFont];
    self.itemView.frame = frame;
}

- (CGSize)sizeWithTitle:(NSString *)title font:(UIFont *)font {
    return [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 100) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName: font} context:nil].size;
}

- (UIColor *)textColor {
    if ([self.itemView isKindOfClass:[UIButton class]]) {
        UIButton *itemView = (UIButton *)self.itemView;
        return [itemView titleColorForState:(UIControlStateNormal)];
    }
    if ([self.itemView isKindOfClass:[UILabel class]]) {
        UILabel *itemView = (UILabel *)self.itemView;
        return itemView.textColor;
    }
    return nil;
}

- (UIFont *)itemFont {
    if ([self.itemView isKindOfClass:[UIButton class]]) {
        UIButton *itemView = (UIButton *)self.itemView;
        return itemView.titleLabel.font;
    }
    if ([self.itemView isKindOfClass:[UILabel class]]) {
        UILabel *itemView = (UILabel *)self.itemView;
        return itemView.font;
    }
    return nil;
}

- (NSString *)title {
    if ([self.itemView isKindOfClass:[UIButton class]]) {
        UIButton *itemView = (UIButton *)self.itemView;
        return [itemView titleForState:(UIControlStateNormal)];
    }
    if ([self.itemView isKindOfClass:[UILabel class]]) {
        UILabel *itemView = (UILabel *)self.itemView;
        return itemView.text;
    }
    return nil;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    if ([self.itemView isKindOfClass:[UIButton class]]) {
        UIButton *itemView = (UIButton *)self.itemView;
        [itemView setTitleColor:_textColor forState:(UIControlStateNormal)];
    }
    if ([self.itemView isKindOfClass:[UILabel class]]) {
        UILabel *itemView = (UILabel *)self.itemView;
        itemView.textColor = _textColor;
    }
}
- (void)setItemFont:(UIFont *)itemFont {
    _itemFont = itemFont;
    if ([self.itemView isKindOfClass:[UIButton class]]) {
        UIButton *itemView = (UIButton *)self.itemView;
        itemView.titleLabel.font = _itemFont;
    }
    if ([self.itemView isKindOfClass:[UILabel class]]) {
        UILabel *itemView = (UILabel *)self.itemView;
        itemView.font = _itemFont;
    }
}
- (void)setTitle:(NSString *)title {
    _title = title;
    if ([self.itemView isKindOfClass:[UIButton class]]) {
        UIButton *itemView = (UIButton *)self.itemView;
        [itemView setTitle:_title forState:(UIControlStateNormal)];
    }
    if ([self.itemView isKindOfClass:[UILabel class]]) {
        UILabel *itemView = (UILabel *)self.itemView;
        itemView.text = _title;
    }
}
@end
