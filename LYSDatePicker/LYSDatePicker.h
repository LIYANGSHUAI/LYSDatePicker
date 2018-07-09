//
//  LYSDatePickerView.h
//  LYSDatePickerDemo
//
//  Created by liyangshuai on 2018/7/1.
//  Copyright © 2018年 liyangshuai. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 In development, I try to reduce the size of the file, just hope that the user does not pay attention to the specific implementation, but just use the provided API to achieve the desired effect, so put all the file classes into a class file, if you open Class .m file sees more than a thousand lines of code in the class, don't dizzy
 
 LYSDatePickerView is mainly implemented using the system's UIDatePicker and UIPickerView controls. It provides two ways for users to choose. If you need to use a similar system date selector, then you can set the parameter @property (nonatomic, assign) LYSDatePickerType type; LYSDatePickerTypeSystem This type just encapsulates the basic functions of UIDatePicker, without adding additional features. If you need a more complicated date picker then you can choose LYSDatePickerTypeCustom, which adds a lot of additional features, of course there may be bugs in the middle, welcome to ask
 */
typedef NS_ENUM(NSUInteger, LYSDatePickerType) {
    LYSDatePickerTypeCustom,                            // Date component is selected UIPickerView
    LYSDatePickerTypeSystem                             // Date component is selected UIDatePicker
};
/*
 The packaged date selector provides five combinations of classes. LYSDatePickerModeTime, LYSDatePickerModeDate, LYSDatePickerModeDateAndTime are applicable to LYSDatePickerTypeCustom, LYSDatePickerTypeSystem two types LYSDatePickerModeYearAndDate, LYSDatePickerModeYearAndDateAndTime are only applicable to LYSDatePickerTypeCustom type, so please add more when using Pay attention to avoid unexpected problems
 
 This parameter is mandatory.
 */
typedef NS_ENUM(NSInteger, LYSDatePickerMode) {
    LYSDatePickerModeTime,                      // Only show time                LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeDate,                      // Show only date                LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeDateAndTime,               // Show date and time            LYSDatePickerTypeCustom | LYSDatePickerTypeSystem
    LYSDatePickerModeYearAndDate,               // Show year and date            LYSDatePickerTypeCustom
    LYSDatePickerModeYearAndDateAndTime         // Show year and date and time   LYSDatePickerTypeCustom
};
/*
 Since the hour can be divided into 12-digit and 24-digit. The following parameters are provided for the function if there is such a requirement. The default is 24 hours.
 */

typedef NS_ENUM(NSUInteger, LYSDatePickerStandard) {
    LYSDatePickerStandard12Hour,                                        // 12-digit
    LYSDatePickerStandard24Hour,                                        // 24-digit
    LYSDatePickerStandardDefault = LYSDatePickerStandard24Hour
};
/*
 When you need a date selector on your needs to display more detailed information every day, such as the week, this feature can help you, the default is not to display
 */
typedef NS_ENUM(NSUInteger, LYSDatePickerWeekDayType) {
    LYSDatePickerWeekDayTypeNone,                                       // NotDisplay
    LYSDatePickerWeekDayTypeWeekdaySymbols,                             // 星期日,星期一,星期二,星期三,星期四,星期五,星期六
    LYSDatePickerWeekDayTypeShortWeekdaySymbols,                        // 周日,周一,周二,周三,周四,周五,周六
    LYSDatePickerWeekDayTypeVeryShortWeekdaySymbols,                    // 日,一,二,三,四,五,六
    LYSDatePickerWeekDayTypeCustom                                      // weekDayArr not is empty
};

extern NSString *const LYSDatePickerDidSelectDateNotifition;

@class LYSDatePicker;
@class LYSDateHeaderBarItem,LYSDateHeaderBar,LYSDateHeadrView;

/// The data of the date selector can be obtained by following the class of the LYSDatePickerViewDataSource protocol.
@protocol LYSDatePickerDataSource<NSObject>

@optional
- (void)datePicker:(LYSDatePicker *)pickerView didSelectDate:(NSDate *)date;
@end

/// Follow the LYSDatePickerViewDelegate protocol to control the layout of higher date selectors
@protocol LYSDatePickerDelegate<NSObject>

@optional
- (CGFloat)datePicker:(LYSDatePicker *)pickerView componentWidthOfIndex:(NSInteger)index;

@end

@interface LYSDatePicker : UIView

/// Data protocol
@property (nonatomic, assign) id<LYSDatePickerDataSource> dataSource;
/// Layout agreement
@property (nonatomic, assign) id<LYSDatePickerDelegate> delegate;

/// Whether to show the top status bar, the default is YES
@property (nonatomic, assign) BOOL enableShowHeader;
/// Status bar view, can not be set to empty, if you want to not display the status bar, you can operate the enableShowHeader property
@property (nonatomic, strong) LYSDateHeadrView *headerView;
/// Height of the status bar
@property (nonatomic, assign) CGFloat headerHeight;
/// contentColor color
@property (nonatomic, strong) UIColor *contentColor;

@property (nonatomic, assign) LYSDatePickerType type;
@property (nonatomic, assign) LYSDatePickerMode datePickerMode;
@property (nonatomic, assign) LYSDatePickerWeekDayType weekDayType;
@property (nonatomic, assign) LYSDatePickerStandard hourStandard;

@property (nonatomic,strong) NSArray<NSString *> *weekDayArr;

@property (nonnull, nonatomic, strong) NSString *AMStr;
@property (nonnull, nonatomic, strong) NSString *PMStr;

/// Whether to display the unit
@property (nonatomic,assign) BOOL allowShowUnit;

/// Date picker's initial date
@property (nonnull, nonatomic, strong) NSDate *date;
/// Minimum deadline for date picker
@property (nonatomic, strong) NSDate *minimumDate;
/// Date deadline for date picker
@property (nonatomic, strong) NSDate *maximumDate;

/// Line height of the date picker
@property (nonatomic,assign) CGFloat rowHeight;

/// The start year of the date picker
@property (nonatomic,assign) NSInteger fromYear;
/// End year of the date picker
@property (nonatomic,assign) NSInteger toYear;

/// Date selector font and font color
@property (nonatomic,strong) UIFont *labelFont;
@property (nonatomic,strong) UIColor *labelColor;


/// update the Date
- (void)updateDate:(NSDate *)date;

/// Date selector initialization method
- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type;
- (instancetype)initWithFrame:(CGRect)frame type:(LYSDatePickerType)type mode:(LYSDatePickerMode)mode;

+ (instancetype)datePickerWithType:(LYSDatePickerType)type;
+ (instancetype)datePickerWithType:(LYSDatePickerType)type mode:(LYSDatePickerMode)mode;
@end

/*
 Date picker status bar view class. If you need to implement a component different from this function, you can inherit this class and operate in its subclass
 */

@interface LYSDateHeadrView : UIView
/// Date picker status bar button carrier
@property (nonatomic, strong) LYSDateHeaderBar *headerBar;
/// Date picker status bar background color, is a hex string, such as #dddddd
@property (nonatomic, strong) NSString *backgroundHexColor;
@end

@interface LYSDateHeaderBar : NSObject

/// Left button class
@property (nonatomic, strong) LYSDateHeaderBarItem *leftBarItem;
/// Right button class
@property (nonatomic, strong) LYSDateHeaderBarItem *rightBarItem;

/// Left button collection class
@property (nonatomic, strong) NSArray<LYSDateHeaderBarItem *> *leftBarItems;
/// Right button collection class
@property (nonatomic, strong) NSArray<LYSDateHeaderBarItem *> *rightBarItems;

/// title
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIView *titleView;
@end

@interface LYSDateHeaderBarItem : NSObject
/// title
@property(nonatomic, copy, readonly) NSString *title;
/// image
@property(nonatomic, strong, readonly) UIImage *image;
/// Custom view
@property(nonatomic, strong, readonly) UIView *customView;

/// Content color
@property(nonatomic, strong) UIColor *tintColor;
/// Content font
@property(nonatomic, strong) UIFont *font;

/// Create a title button
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action;
/// Create a picture button
- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action;
/// Create a custom view button
- (instancetype)initWithCustomView:(UIView *)customView;
@end

@interface LYSDateHeaderBarContent : UIView
@end
