//
//  FSCustomButton.h
//  FSCustomButtonDemo
//
//  Created by huim on 2017/6/13.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FSCustomButtonLayoutTypeLeft,
    FSCustomButtonLayoutTypeRight,
    FSCustomButtonLayoutTypeTop,
    FSCustomButtonLayoutTypeBottom,
} FSCustomButtonLayoutType;

@interface FSCustomButton : UIButton

@property (nonatomic, assign) FSCustomButtonLayoutType buttonLayoutType;

@end
