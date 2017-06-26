# FSCustomButtonDemo
自定义按钮布局样式

**详细分析文档请点这里**：[iOS一步步实现一个高度自定义UIButton控件](http://www.jianshu.com/p/4603e9bbba56)
## 效果图
![FSCustomButtonDemo.gif](http://upload-images.jianshu.io/upload_images/1792044-beb61c6dc89a4485.gif?imageMogr2/auto-orient/strip)
## 使用方式
将demo中的FSCustomButton文件夹拖入项目，导入**FSCustomButton.h**

## API使用

```objc
typedef enum : NSUInteger {
    FSCustomButtonImagePositionLeft,//图片在左
    FSCustomButtonImagePositionRight,//图片在右
    FSCustomButtonImagePositionTop,//图片在上
    FSCustomButtonImagePositionBottom,//图片在下
} FSCustomButtonImagePosition;

@interface FSCustomButton : UIButton

/**
 图片位置
 */
@property (nonatomic, assign) FSCustomButtonImagePosition buttonImagePosition;

/**
 文字颜色自动跟随tintColor调整,default NO
 */
@property(nonatomic, assign) BOOL adjustsTitleTintColorAutomatically;

/**
 图片颜色自动跟随tintColor调整,default NO
 */
@property(nonatomic, assign) BOOL adjustsImageTintColorAutomatically;

/**
 default YES;相当于系统的adjustsImageWhenHighlighted
 */
@property(nonatomic, assign) BOOL adjustsButtonWhenHighlighted;

/**
 default YES,相当于系统的adjustsImageWhenDisabled
 */
@property(nonatomic, assign) BOOL adjustsButtonWhenDisabled;

/**
 高亮状态button背景色，default nil，设置此属性后默认adjustsButtonWhenHighlighted=NO
 */
@property(nonatomic, strong) UIColor *highlightedBackgroundColor;

/**
 高亮状态边框颜色，default nil，设置此属性后默认adjustsButtonWhenHighlighted=NO
 */
@property(nonatomic, strong) UIColor *highlightedBorderColor;
```

## 使用示例
详细使用建议查看demo

```objc
 FSCustomButton *button = [[FSCustomButton alloc] initWithFrame:CGRectMake(100, 20, 100, 80)];
    button.adjustsTitleTintColorAutomatically = YES;
    [button setTintColor:UIColorMake(27, 31, 35)];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitle:@"图片在上" forState:UIControlStateNormal];
    button.backgroundColor = UIColorMake(222, 234, 214);
    [button setImage:[UIImage imageNamed:@"my_ic_coupon"] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.buttonImagePosition = FSCustomButtonImagePositionTop;
    button.titleEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:button];
//    [button sizeToFit];
    
    FSCustomButton *button2 = [[FSCustomButton alloc] initWithFrame:CGRectMake(100, 120, 100, 80)];
    button2.adjustsTitleTintColorAutomatically = YES;
    [button2 setTintColor:UIColorMake(27, 31, 35)];
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button2 setTitle:@"图片在下" forState:UIControlStateNormal];
    button2.backgroundColor = UIColorMake(222, 234, 214);
    [button2 setImage:[UIImage imageNamed:@"my_ic_coupon"] forState:UIControlStateNormal];
    button2.layer.cornerRadius = 4;
    button2.buttonImagePosition = FSCustomButtonImagePositionBottom;
    button2.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:button2];
```



