//
//  CALayer+FSUI.h
//  FSCustomButtonDemo
//
//  Created by huim on 2017/6/14.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (FSUI)
/**
 *  把某个sublayer移动到当前所有sublayers的最后面
 *  @param  sublayer    要被移动的layer
 *  @warning 要被移动的sublayer必须已经添加到当前layer上
 */
- (void)FS_sendSublayerToBack:(CALayer *)sublayer;

/**
 *  把某个sublayer移动到当前所有sublayers的最前面
 *  @param  sublayer    要被移动的layer
 *  @warning 要被移动的sublayer必须已经添加到当前layer上
 */
- (void)FS_bringSublayerToFront:(CALayer *)sublayer;

/**
 * 移除 CALayer（包括 CAShapeLayer 和 CAGradientLayer）所有支持动画的属性的默认动画，方便需要一个不带动画的 layer 时使用。
 */
- (void)FS_removeDefaultAnimations;
@end
