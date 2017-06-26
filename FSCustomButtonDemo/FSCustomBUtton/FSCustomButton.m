//
//  FSCustomButton.m
//  FSCustomButtonDemo
//
//  Created by huim on 2017/6/13.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "FSCustomButton.h"
#import "FSCommenDefine.h"
#import "CALayer+FSUI.h"

@interface FSCustomButton ()
@property(nonatomic, strong) CALayer *highlightedBackgroundLayer;
@property(nonatomic, strong) UIColor *originBorderColor;
@end

@implementation FSCustomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    self.adjustsTitleTintColorAutomatically = NO;
    self.adjustsImageTintColorAutomatically = NO;
    self.tintColor = [UIColor colorWithRed:43/255 green:133/255 blue:208/255 alpha:1];
    if (!self.adjustsTitleTintColorAutomatically) {
        [self setTitleColor:[UIColor colorWithRed:43/255 green:133/255 blue:208/255 alpha:1] forState:UIControlStateNormal];
    }
    
    // 默认接管highlighted和disabled的表现，去掉系统默认的表现
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.adjustsButtonWhenHighlighted = YES;
    self.adjustsButtonWhenDisabled = YES;
    
    // iOS7以后的button，sizeToFit后默认会自带一个上下的contentInsets，为了保证按钮大小即为内容大小，这里直接去掉，改为一个最小的值。
    // 不能设为0，否则无效；也不能设置为小数点，否则无法像素对齐
    self.contentEdgeInsets = UIEdgeInsetsMake(1, 0, 1, 0);
    
    self.buttonImagePosition = FSCustomButtonImagePositionLeft;//默认布局
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //size存在空的情况
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    //默认布局不用处理
    if (self.buttonImagePosition == FSCustomButtonImagePositionLeft) {
        return;
    }
    //content的实际size
    CGSize contentSize = CGSizeMake(CGRectGetWidth(self.bounds) - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets), CGRectGetHeight(self.bounds) - UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets));
    //垂直布局
    if (self.buttonImagePosition == FSCustomButtonImagePositionTop || self.buttonImagePosition == FSCustomButtonImagePositionBottom) {
        
        CGFloat imageLimitWidth = contentSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets);
        CGSize imageSize = [self.imageView sizeThatFits:CGSizeMake(imageLimitWidth, CGFLOAT_MAX)];// 假设图片高度必定完整显示
        CGRect imageFrame = CGRectMakeWithSize(imageSize);
        
        CGSize titleLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) - imageSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
        CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
        titleSize.height = fminf(titleSize.height, titleLimitSize.height);
        CGRect titleFrame = CGRectMakeWithSize(titleSize);
        //到这里image和title都是扣除了偏移量后的实际size，frame重置为x/y=0
        
        
        switch (self.contentHorizontalAlignment) {//重置X坐标
            case UIControlContentHorizontalAlignmentLeft:
                imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left);
                titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                break;
            case UIControlContentHorizontalAlignmentCenter:
                imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left + CGFloatGetCenter(imageLimitWidth, imageSize.width));
                titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left + CGFloatGetCenter(titleLimitSize.width, titleSize.width));
                break;
            case UIControlContentHorizontalAlignmentRight:
                imageFrame = CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - imageSize.width);
                titleFrame = CGRectSetX(titleFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.titleEdgeInsets.right - titleSize.width);
                break;
            case UIControlContentHorizontalAlignmentFill://此时要铺满button，所以要重置width
                imageFrame = CGRectSetX(imageFrame, self.contentEdgeInsets.left + self.imageEdgeInsets.left);
                imageFrame = CGRectSetWidth(imageFrame, imageLimitWidth);
                titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                titleFrame = CGRectSetWidth(titleFrame, titleLimitSize.width);
                break;
        }
        
        if (self.buttonImagePosition == FSCustomButtonImagePositionTop) {//重置Y坐标
            switch (self.contentVerticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                    imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                    titleFrame = CGRectSetY(titleFrame, CGRectGetMaxY(imageFrame) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top);
                    break;
                case UIControlContentVerticalAlignmentCenter: {
                    CGFloat contentHeight = CGRectGetHeight(imageFrame) + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) + CGRectGetHeight(titleFrame) + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets);
                    CGFloat minY = CGFloatGetCenter(contentSize.height, contentHeight) + self.contentEdgeInsets.top;
                    imageFrame = CGRectSetY(imageFrame, minY + self.imageEdgeInsets.top);
                    titleFrame = CGRectSetY(titleFrame, CGRectGetMaxY(imageFrame) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top);
                }
                    break;
                case UIControlContentVerticalAlignmentBottom:
                    titleFrame = CGRectSetY(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetHeight(titleFrame));
                    imageFrame = CGRectSetY(imageFrame, CGRectGetMinY(titleFrame) - self.titleEdgeInsets.top - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame));
                    break;
                case UIControlContentVerticalAlignmentFill:
                    // 图片按自身大小显示，剩余空间由标题占满
                    imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                    titleFrame = CGRectSetY(titleFrame, CGRectGetMaxY(imageFrame) + self.imageEdgeInsets.bottom + self.titleEdgeInsets.top);
                    titleFrame = CGRectSetHeight(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetMinY(titleFrame));
                    break;
            }
        } else {
            switch (self.contentVerticalAlignment) {
                case UIControlContentVerticalAlignmentTop:
                    titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                    imageFrame = CGRectSetY(imageFrame, CGRectGetMaxY(titleFrame) + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top);
                    break;
                case UIControlContentVerticalAlignmentCenter: {
                    CGFloat contentHeight = CGRectGetHeight(titleFrame) + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets) + CGRectGetHeight(imageFrame) + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets);
                    CGFloat minY = CGFloatGetCenter(contentSize.height, contentHeight) + self.contentEdgeInsets.top;
                    titleFrame = CGRectSetY(titleFrame, minY + self.titleEdgeInsets.top);
                    imageFrame = CGRectSetY(imageFrame, CGRectGetMaxY(titleFrame) + self.titleEdgeInsets.bottom + self.imageEdgeInsets.top);
                }
                    break;
                case UIControlContentVerticalAlignmentBottom:
                    imageFrame = CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame));
                    titleFrame = CGRectSetY(titleFrame, CGRectGetMinY(imageFrame) - self.imageEdgeInsets.top - self.titleEdgeInsets.bottom - CGRectGetHeight(titleFrame));
                    
                    break;
                case UIControlContentVerticalAlignmentFill:
                    // 图片按自身大小显示，剩余空间由标题占满
                    imageFrame = CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame));
                    titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                    titleFrame = CGRectSetHeight(titleFrame, CGRectGetMinY(imageFrame) - self.imageEdgeInsets.top - self.titleEdgeInsets.bottom - CGRectGetMinY(titleFrame));
                    break;
            }
        }
        
        self.imageView.frame = CGRectFlatted(imageFrame);
        self.titleLabel.frame = CGRectFlatted(titleFrame);
        
    } else if (self.buttonImagePosition == FSCustomButtonImagePositionRight) {//水平布局
        
        CGFloat imageLimitHeight = contentSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets);
        CGSize imageSize = [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, imageLimitHeight)];// 假设图片宽度必定完整显示，高度不超过按钮内容
        CGRect imageFrame = CGRectMakeWithSize(imageSize);
        
        CGSize titleLimitSize = CGSizeMake(contentSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) - CGRectGetWidth(imageFrame) - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), contentSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
        CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
        titleSize.height = fminf(titleSize.height, titleLimitSize.height);
        CGRect titleFrame = CGRectMakeWithSize(titleSize);
        
        switch (self.contentHorizontalAlignment) {
            case UIControlContentHorizontalAlignmentLeft:
                titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                imageFrame = CGRectSetX(imageFrame, CGRectGetMaxX(titleFrame) + self.titleEdgeInsets.right + self.imageEdgeInsets.left);
                break;
            case UIControlContentHorizontalAlignmentCenter: {
                CGFloat contentWidth = CGRectGetWidth(titleFrame) + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) + CGRectGetWidth(imageFrame) + UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets);
                CGFloat minX = self.contentEdgeInsets.left + CGFloatGetCenter(contentSize.width, contentWidth);
                titleFrame = CGRectSetX(titleFrame, minX + self.titleEdgeInsets.left);
                imageFrame = CGRectSetX(imageFrame, CGRectGetMaxX(titleFrame) + self.titleEdgeInsets.right + self.imageEdgeInsets.left);
            }
                break;
            case UIControlContentHorizontalAlignmentRight:
                imageFrame = CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageFrame));
                titleFrame = CGRectSetX(titleFrame, CGRectGetMinX(imageFrame) - self.imageEdgeInsets.left - self.titleEdgeInsets.right - CGRectGetWidth(titleFrame));
                break;
            case UIControlContentHorizontalAlignmentFill:
                // 图片按自身大小显示，剩余空间由标题占满
                imageFrame = CGRectSetX(imageFrame, CGRectGetWidth(self.bounds) - self.contentEdgeInsets.right - self.imageEdgeInsets.right - CGRectGetWidth(imageFrame));
                titleFrame = CGRectSetX(titleFrame, self.contentEdgeInsets.left + self.titleEdgeInsets.left);
                titleFrame = CGRectSetWidth(titleFrame, CGRectGetMinX(imageFrame) - self.imageEdgeInsets.left - self.titleEdgeInsets.right - CGRectGetMinX(titleFrame));
                break;
        }
        
        switch (self.contentVerticalAlignment) {
            case UIControlContentVerticalAlignmentTop:
                titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                break;
            case UIControlContentVerticalAlignmentCenter:
                titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top + CGFloatGetCenter(contentSize.height, CGRectGetHeight(titleFrame) + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets)));
                imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top + CGFloatGetCenter(contentSize.height, CGRectGetHeight(imageFrame) + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets)));
                break;
            case UIControlContentVerticalAlignmentBottom:
                titleFrame = CGRectSetY(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetHeight(titleFrame));
                imageFrame = CGRectSetY(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetHeight(imageFrame));
                break;
            case UIControlContentVerticalAlignmentFill:
                titleFrame = CGRectSetY(titleFrame, self.contentEdgeInsets.top + self.titleEdgeInsets.top);
                titleFrame = CGRectSetHeight(titleFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.titleEdgeInsets.bottom - CGRectGetMinY(titleFrame));
                imageFrame = CGRectSetY(imageFrame, self.contentEdgeInsets.top + self.imageEdgeInsets.top);
                imageFrame = CGRectSetHeight(imageFrame, CGRectGetHeight(self.bounds) - self.contentEdgeInsets.bottom - self.imageEdgeInsets.bottom - CGRectGetMinY(imageFrame));
                break;
        }
        
        self.imageView.frame = CGRectFlatted(imageFrame);
        self.titleLabel.frame = CGRectFlatted(titleFrame);
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    // 如果调用 sizeToFit，那么传进来的 size 就是当前按钮的 size，此时的计算不要去限制宽高
    if (CGSizeEqualToSize(self.bounds.size, size)) {
        size = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    }
    
    CGSize resultSize = CGSizeZero;
    CGSize contentLimitSize = CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets), size.height - UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets));
    switch (self.buttonImagePosition) {
        case FSCustomButtonImagePositionTop:
        case FSCustomButtonImagePositionBottom: {
            // 图片和文字上下排版时，宽度以文字或图片的最大宽度为最终宽度
            CGFloat imageLimitWidth = contentLimitSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets);
            CGSize imageSize = [self.imageView sizeThatFits:CGSizeMake(imageLimitWidth, CGFLOAT_MAX)];// 假设图片高度必定完整显示
            
            CGSize titleLimitSize = CGSizeMake(contentLimitSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets), contentLimitSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) - imageSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
            CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
            titleSize.height = fminf(titleSize.height, titleLimitSize.height);
            
            resultSize.width = UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets);
            resultSize.width += fmaxf(UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets) + imageSize.width, UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) + titleSize.width);
            resultSize.height = UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets) + UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) + imageSize.height + UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets) + titleSize.height;
        }
            break;
            
        case FSCustomButtonImagePositionLeft:
        case FSCustomButtonImagePositionRight: {
            if (self.buttonImagePosition == FSCustomButtonImagePositionLeft && self.titleLabel.numberOfLines == 1) {
                
                resultSize = [super sizeThatFits:size];
                
            } else {
                // 图片和文字水平排版时，高度以文字或图片的最大高度为最终高度
                
                CGFloat imageLimitHeight = contentLimitSize.height - UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets);
                CGSize imageSize = [self.imageView sizeThatFits:CGSizeMake(CGFLOAT_MAX, imageLimitHeight)];// 假设图片宽度必定完整显示，高度不超过按钮内容
                
                CGSize titleLimitSize = CGSizeMake(contentLimitSize.width - UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) - imageSize.width - UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets), contentLimitSize.height - UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets));
                CGSize titleSize = [self.titleLabel sizeThatFits:titleLimitSize];
                titleSize.height = fminf(titleSize.height, titleLimitSize.height);
                
                resultSize.width = UIEdgeInsetsGetHorizontalValue(self.contentEdgeInsets) + UIEdgeInsetsGetHorizontalValue(self.imageEdgeInsets) + imageSize.width + UIEdgeInsetsGetHorizontalValue(self.titleEdgeInsets) + titleSize.width;
                resultSize.height = UIEdgeInsetsGetVerticalValue(self.contentEdgeInsets);
                resultSize.height += fmaxf(UIEdgeInsetsGetVerticalValue(self.imageEdgeInsets) + imageSize.height, UIEdgeInsetsGetVerticalValue(self.titleEdgeInsets) + titleSize.height);
            }
        }
            break;
    }
    return resultSize;
}

#pragma mark setter

- (void)setButtonImagePosition:(FSCustomButtonImagePosition)buttonImagePosition
{
    _buttonImagePosition = buttonImagePosition;
    [self setNeedsLayout];
}

- (void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor {
    _highlightedBackgroundColor = highlightedBackgroundColor;
    if (_highlightedBackgroundColor) {
        // 只要开启了highlightedBackgroundColor，就默认不需要alpha的高亮
        self.adjustsButtonWhenHighlighted = NO;
    }
}

- (void)setHighlightedBorderColor:(UIColor *)highlightedBorderColor {
    _highlightedBorderColor = highlightedBorderColor;
    if (_highlightedBorderColor) {
        // 只要开启了highlightedBorderColor，就默认不需要alpha的高亮
        self.adjustsButtonWhenHighlighted = NO;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted && !self.originBorderColor) {
        // 手指按在按钮上会不断触发setHighlighted:，所以这里做了保护，设置过一次就不用再设置了
        self.originBorderColor = [UIColor colorWithCGColor:self.layer.borderColor];
    }
    
    // 渲染背景色
    if (self.highlightedBackgroundColor || self.highlightedBorderColor) {
        [self adjustsButtonHighlighted];
    }
    // 如果此时是disabled，则disabled的样式优先
    if (!self.enabled) {
        return;
    }
    // 自定义highlighted样式
    if (self.adjustsButtonWhenHighlighted) {
        if (highlighted) {
            self.alpha = 0.5f;
        } else {
            [UIView animateWithDuration:0.25f animations:^{
                self.alpha = 1;
            }];
        }
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (!enabled && self.adjustsButtonWhenDisabled) {
        self.alpha = 0.5f;//disabled的透明度
    } else {
        [UIView animateWithDuration:0.25f animations:^{
            self.alpha = 1;
        }];
    }
}

- (void)adjustsButtonHighlighted {
    if (self.highlightedBackgroundColor) {
        if (!self.highlightedBackgroundLayer) {
            self.highlightedBackgroundLayer = [CALayer layer];//创建一个新的不带动画的layer
            [self.highlightedBackgroundLayer FS_removeDefaultAnimations];//移除系统默认的隐性动画
            [self.layer insertSublayer:self.highlightedBackgroundLayer atIndex:0];//替换为自定义的layer
        }
        //为新的layer添加属性
        self.highlightedBackgroundLayer.frame = self.bounds;
        self.highlightedBackgroundLayer.cornerRadius = self.layer.cornerRadius;
        self.highlightedBackgroundLayer.backgroundColor = self.highlighted ? self.highlightedBackgroundColor.CGColor : [UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor;
    }
    
    if (self.highlightedBorderColor) {
        self.layer.borderColor = self.highlighted ? self.highlightedBorderColor.CGColor : self.originBorderColor.CGColor;
    }
}

- (void)setAdjustsTitleTintColorAutomatically:(BOOL)adjustsTitleTintColorAutomatically {
    _adjustsTitleTintColorAutomatically = adjustsTitleTintColorAutomatically;
    [self updateTitleColorIfNeeded];
}
//title的color变化时调用
- (void)updateTitleColorIfNeeded {
    if (self.adjustsTitleTintColorAutomatically && self.currentTitleColor) {
        [self setTitleColor:self.tintColor forState:UIControlStateNormal];
    }
    if (self.adjustsTitleTintColorAutomatically && self.currentAttributedTitle) {//title为属性字符串的时候
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.currentAttributedTitle];
        [attributedString addAttribute:NSForegroundColorAttributeName value:self.tintColor range:NSMakeRange(0, attributedString.length)];
        [self setAttributedTitle:attributedString forState:UIControlStateNormal];
    }
}
//设置图片的渲染颜色与tintColor一样
- (void)setAdjustsImageTintColorAutomatically:(BOOL)adjustsImageTintColorAutomatically {
    BOOL valueDifference = _adjustsImageTintColorAutomatically != adjustsImageTintColorAutomatically;
    _adjustsImageTintColorAutomatically = adjustsImageTintColorAutomatically;
    
    if (valueDifference) {
        [self updateImageRenderingModeIfNeeded];
    }
}

- (void)updateImageRenderingModeIfNeeded {
    if (self.currentImage) {
        NSArray<NSNumber *> *states = @[@(UIControlStateNormal), @(UIControlStateHighlighted), @(UIControlStateDisabled)];
        for (NSNumber *number in states) {
            UIImage *image = [self imageForState:[number unsignedIntegerValue]];
            if (!image) {
                continue;
            }
            
            if (self.adjustsImageTintColorAutomatically) {
                // 这里的image不用做renderingMode的处理，而是放到重写的setImage:forState里去做
                [self setImage:image forState:[number unsignedIntegerValue]];
            } else {
                // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                [self setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:[number unsignedIntegerValue]];
            }
        }
    }
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (self.adjustsImageTintColorAutomatically) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [super setImage:image forState:state];
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    
    [self updateTitleColorIfNeeded];
    
    if (self.adjustsImageTintColorAutomatically) {
        [self updateImageRenderingModeIfNeeded];
    }
}


@end
