# LYSDatePicker

当前最高版本:0.0.2

LYSDatePicker is mainly to adapt to the scenes that need to choose the date in daily development. The bottom layer is mainly implemented by UIPickerView and UIDatePicker components. Since this is just released, there may be bugs in the middle of use, so you need to ask for it, I will try to fix it.

![iOS技术群群二维码](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/iOS技术群群二维码.JPG)

使用方法:(目前支持iOS 8.0以上)

其实这个插件我没有在iOS 8.0以下测过,自我认为应该没有使用那些iOS 8之前和之后有改动的API,但是我在集成Cocoapods时,选的支持环境是iOS 8以上,如果要在iOS 8以下使用,直接拷贝文件到项目即可

为了方便大家引入,我加入了Cocoapods管理,使用终端 pod search LYSDatePicker

不出意外的情况下,会查出

```objc
-> LYSDatePicker (版本号)
I hope everyone will give me some advice during the process of use. I want to
go further.
pod 'LYSDatePicker', '~> 版本号'
- Homepage: https://github.com/LIYANGSHUAI/LYSDatePicker
- Source:   https://github.com/LIYANGSHUAI/LYSDatePicker.git
- Versions: 版本列表 [master repo]
(END)
```
直接粘贴: pod 'LYSDatePicker', '~> 版本号'

Here is the usage scenario I thought of as much as possible, as a reference

![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/目录.png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/系统(时间).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/系统(日期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/系统(日期和时间).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(时间).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(时间12小时).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(日期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(日期和星期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(日期和时间).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(日期和时间和星期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(年和日期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(年和日期和时间).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(年和日期和时间和星期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(年和日期和星期).png)
![效果图](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/自定义(年和日期和时间和星期12小时).png)

```objc
LYSDatePicker *pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeSystem)];
pickerView.datePickerMode = LYSDatePickerModeTime;
pickerView.date = [NSDate date];
pickerView.headerView.headerBar = self.headerBar;
pickerView.delegate = self;
pickerView.dataSource = self;
[self.view addSubview:pickerView];
```

```objc
LYSDatePicker *pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
pickerView.datePickerMode = LYSDatePickerModeTime;
pickerView.date = [NSDate date];
pickerView.headerView.headerBar = self.headerBar;
pickerView.delegate = self;
pickerView.dataSource = self;
[self.view addSubview:pickerView];
```

```objc
LYSDatePicker *pickerView = [[LYSDatePicker alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.frame), 256) type:(LYSDatePickerTypeCustom)];
pickerView.datePickerMode = LYSDatePickerModeTime;
pickerView.hourStandard = LYSDatePickerStandard12Hour;
pickerView.date = [NSDate date];

LYSDateHeaderBarItem *cancelItem = [[LYSDateHeaderBarItem alloc] initWithImage:[UIImage imageNamed:@"cancel"] target:self action:@selector(cancelAction:)];
cancelItem.tintColor = [UIColor whiteColor];

LYSDateHeaderBarItem *commitItem = [[LYSDateHeaderBarItem alloc] initWithImage:[UIImage imageNamed:@"fit"] target:self action:@selector(commitAction:)];
commitItem.tintColor = [UIColor whiteColor];

self.headerBar = [[LYSDateHeaderBar alloc] init];
self.headerBar.leftBarItem = cancelItem;
self.headerBar.rightBarItem = commitItem;
self.headerBar.title = @"日期选择器";
self.headerBar.titleColor = [UIColor whiteColor];

pickerView.headerView.headerBar = self.headerBar;
pickerView.delegate = self;
pickerView.dataSource = self;
[self.view addSubview:pickerView];
```

大体的使用方法如上所示,大家可以通过下面的四个枚举值进行不同场景适配

```objc
@property (nonatomic, assign) LYSDatePickerType type;
@property (nonatomic, assign) LYSDatePickerMode datePickerMode;
@property (nonatomic, assign) LYSDatePickerWeekDayType weekDayType;
@property (nonatomic, assign) LYSDatePickerStandard hourStandard;
```
当遇到屏幕宽度不能够完全显示组件时,可以实现如下代理
```objc
/// Follow the LYSDatePickerViewDelegate protocol to control the layout of higher date selectors
@protocol LYSDatePickerDelegate<NSObject>

@optional
- (CGFloat)datePicker:(LYSDatePicker *)pickerView componentWidthOfIndex:(NSInteger)index;

@end
```
当然还有一个方法也可以解决不完全显示问题

```objc
@property (nonatomic,strong) UIFont *labelFont;
```
可以通过设置显示字体大小,来间接的调整显示范围,因为部分实现源码如下:

```objc
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:componentWidthOfIndex:)]) {
return [self.delegate datePicker:self componentWidthOfIndex:component];
}

CGFloat fontSize = self.labelFont.pointSize;

CGFloat year = 50*fontSize/14;
CGFloat month = 35*fontSize/14;
CGFloat hour = 40*fontSize/14;
CGFloat minute = 40*fontSize/14;
CGFloat timeType = 30*fontSize/14;

CGFloat day = 80*fontSize/14;

MatchWeekDayType(None,                                  day = 60*fontSize/14;)
MatchWeekDayType(WeekdaySymbols,                        day = 80*fontSize/14;)
MatchWeekDayType(ShortWeekdaySymbols,                   day = 70*fontSize/14;)
MatchWeekDayType(VeryShortWeekdaySymbols,               day = 60*fontSize/14;)
MatchWeekDayType(Custom,                                day = 80*fontSize/14;)

MatchDatePickerMode(Time,                   {
Match(component == 0,                               {return hour;})
Match(component == 1,                               {return minute;})
Match(component == 2,                               {return timeType;})
})
MatchDatePickerMode(Date,                   {
Match(component == 0,                               {return month;})
Match(component == 1,                               {return day;})
})
MatchDatePickerMode(DateAndTime,            {
Match(component == 0,                               {return month;})
Match(component == 1,                               {return day;})
Match(component == 2,                               {return hour;})
Match(component == 3,                               {return minute;})
Match(component == 4,                               {return timeType;})
})
MatchDatePickerMode(YearAndDate,            {
Match(component == 0,                               {return year;})
Match(component == 1,                               {return month;})
Match(component == 2,                               {return day;})
})
MatchDatePickerMode(YearAndDateAndTime,     {
Match(component == 0,                               {return year;})
Match(component == 1,                               {return month;})
Match(component == 2,                               {return day;})
Match(component == 3,                               {return hour;})
Match(component == 4,                               {return minute;})
Match(component == 5,                               {return timeType;})
})

return 45;
}
```
我是在iPhone 5s 4.0手机屏幕下测试的,我用14号的字体作为参考

![2](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/2.png)
![1](https://github.com/LIYANGSHUAI/LYSDatePicker/blob/master/resource/1.png)


