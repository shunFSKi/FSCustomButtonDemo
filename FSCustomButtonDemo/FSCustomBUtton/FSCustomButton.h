//
//  FSCustomButton.h
//  FSCustomButtonDemo
//
//  Created by huim on 2017/6/13.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@end
