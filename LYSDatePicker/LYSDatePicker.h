//
//  LYSDatePickerView.h
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LYSDatePickerType) {
    LYSDatePickerTypeCustom,                            // 使用 UIPickerView 组件实现
    LYSDatePickerTypeSystem                             // 使用系统 UIDatePicker 组件实现
};

typedef NS_ENUM(NSInteger, LYSDatePickerMode) {
    LYSDatePickerModeTime,                      // 只显示时间             使用范围: LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeDate,                      // 只显示日期             使用范围: LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeDateAndTime,               // 显示日期和时间          使用范围: LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeYearAndDate,               // 显示年和日期            使用范围: LYSDatePickerTypeCustom
    LYSDatePickerModeYearAndDateAndTime         // 显示年和日期和时间       使用范围: LYSDatePickerTypeCustom
};
/*
 时间显示,12小时制,24小时制,默认是24小时制
 */

typedef NS_ENUM(NSUInteger, LYSDatePickerStandard) {
    LYSDatePickerStandard12Hour,                                        // 12小时
    LYSDatePickerStandard24Hour,                                        // 24小时
    LYSDatePickerStandardDefault = LYSDatePickerStandard24Hour
};
/*
 星期选择类型
 */
typedef NS_ENUM(NSUInteger, LYSDatePickerWeekDayType) {
    LYSDatePickerWeekDayTypeNone,                                       // 不显示星期
    LYSDatePickerWeekDayTypeWeekdaySymbols,                             // 星期日,星期一,星期二,星期三,星期四,星期五,星期六
    LYSDatePickerWeekDayTypeShortWeekdaySymbols,                        // 周日,周一,周二,周三,周四,周五,周六
    LYSDatePickerWeekDayTypeVeryShortWeekdaySymbols,                    // 日,一,二,三,四,五,六
    LYSDatePickerWeekDayTypeCustom                                      // 如果设置为这个属性,那么weekDayArr属性不能是空的,必须设置,否则报错
};

extern NSString * _Nullable const LYSDatePickerDidSelectDateNotifition;

@class LYSDatePicker;
@class LYSDateHeaderBarItem,LYSDateHeaderBar,LYSDateHeadrView;

@protocol LYSDatePickerDataSource<NSObject>

@optional
// 组件滚动结束后触发这个代理方法,返回选择日期
- (void)datePicker:(LYSDatePicker *_Nullable)pickerView didSelectDate:(NSDate *_Nullable)date;
@end

@protocol LYSDatePickerDelegate<NSObject>

@optional
// 设置某一列宽度
- (CGFloat)datePicker:(LYSDatePicker *_Nullable)pickerView componentWidthOfIndex:(NSInteger)index;

@end

@interface LYSDatePicker : UIView

/// 数据源代理
@property (nonatomic, assign) id<LYSDatePickerDataSource> _Nullable dataSource;
/// 操作代理
@property (nonatomic, assign) id<LYSDatePickerDelegate> _Nullable delegate;

/// 是否显示顶部工具栏,默认是显示
@property (nonatomic, assign) BOOL enableShowHeader;
/// 顶部工具栏
@property (nonatomic, strong) LYSDateHeadrView * _Nullable headerView;
/// 顶部工具类高度
@property (nonatomic, assign) CGFloat headerHeight;
/// 内容背景色
@property (nonatomic, strong) UIColor * _Nullable contentColor;

@property (nonatomic, assign) LYSDatePickerType type;
@property (nonatomic, assign) LYSDatePickerMode datePickerMode;
@property (nonatomic, assign) LYSDatePickerWeekDayType weekDayType;
@property (nonatomic, assign) LYSDatePickerStandard hourStandard;

/// 日期显示字符串,和LYSDatePickerWeekDayTypeCustom配合使用
@property (nonatomic,strong) NSArray<NSString *> * _Nullable weekDayArr;

/// 上下午显示字符串
@property (nonnull, nonatomic, strong) NSString *AMStr;
@property (nonnull, nonatomic, strong) NSString *PMStr;

/// 是否显示上下午
@property (nonatomic,assign) BOOL allowShowUnit;

/// 初始化日期
@property (nonnull, nonatomic, strong) NSDate *date;
/// 最小时间
@property (nonatomic, strong) NSDate * _Nullable minimumDate;
///最大时间
@property (nonatomic, strong) NSDate * _Nullable maximumDate;

/// 行高
@property (nonatomic,assign) CGFloat rowHeight;

/// 从哪一年开始
@property (nonatomic,assign) NSInteger fromYear;
/// 从哪一年结束
@property (nonatomic,assign) NSInteger toYear;

/// 字体
@property (nonatomic,strong) UIFont * _Nullable labelFont;
/// 颜色
@property (nonatomic,strong) UIColor * _Nullable labelColor;


/// 更新显示日期
- (void)updateDate:(NSDate *_Nullable)date;

/// 初始化方法
- (instancetype _Nullable )initWithFrame:(CGRect)frame type:(LYSDatePickerType)type;
- (instancetype _Nullable )initWithFrame:(CGRect)frame type:(LYSDatePickerType)type mode:(LYSDatePickerMode)mode;

+ (instancetype _Nullable )datePickerWithType:(LYSDatePickerType)type;
+ (instancetype _Nonnull )datePickerWithType:(LYSDatePickerType)type mode:(LYSDatePickerMode)mode;
@end

/*
 工具栏
 */

@interface LYSDateHeadrView : UIView
/// 工具类
@property (nonatomic, strong) LYSDateHeaderBar * _Nullable headerBar;
/// 背景颜色
@property (nonatomic, strong) NSString * _Nullable backgroundHexColor;
@end

@interface LYSDateHeaderBar : NSObject

/// 左边按钮类
@property (nonatomic, strong) LYSDateHeaderBarItem * _Nullable leftBarItem;
/// 右边按钮类
@property (nonatomic, strong) LYSDateHeaderBarItem * _Nullable rightBarItem;

/// 左边按钮数组
@property (nonatomic, strong) NSArray<LYSDateHeaderBarItem *> * _Nullable leftBarItems;
/// 右边按钮数组
@property (nonatomic, strong) NSArray<LYSDateHeaderBarItem *> * _Nullable rightBarItems;

/// 标题
@property (nonatomic, copy) NSString * _Nullable title;
@property (nonatomic, strong) UIColor * _Nullable titleColor;
@property (nonatomic, strong) UIFont * _Nullable titleFont;
@property (nonatomic, strong) UIView * _Nullable titleView;
@end

@interface LYSDateHeaderBarItem : NSObject
/// 标题
@property(nonatomic, copy, readonly) NSString * _Nullable title;
/// 图片
@property(nonatomic, strong, readonly) UIImage * _Nullable image;
/// 自定义视图
@property(nonatomic, strong, readonly) UIView * _Nullable customView;

/// 显示颜色
@property(nonatomic, strong) UIColor * _Nullable tintColor;
/// 显示字体
@property(nonatomic, strong) UIFont * _Nullable font;

/// 初始化方法
- (instancetype _Nullable )initWithTitle:(NSString *_Nullable)title target:(id _Nullable )target action:(SEL _Nullable )action;
- (instancetype _Nullable )initWithImage:(UIImage *_Nullable)image target:(id _Nullable )target action:(SEL _Nullable )action;
- (instancetype _Nullable )initWithCustomView:(UIView *_Nullable)customView;
@end

@interface LYSDateHeaderBarContent : UIView
@end
