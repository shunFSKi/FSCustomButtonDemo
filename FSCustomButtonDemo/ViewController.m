//
//  ViewController.m
//  FSCustomButtonDemo
//
//  Created by huim on 2017/6/13.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "ViewController.h"
#import "FSCustomButton.h"
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    
    FSCustomButton *button3 = [[FSCustomButton alloc] initWithFrame:CGRectMake(220, 20, 100, 80)];
    button3.adjustsTitleTintColorAutomatically = YES;
    [button3 setTintColor:UIColorMake(27, 31, 35)];
    button3.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button3 setTitle:@"sizeToFit" forState:UIControlStateNormal];
    button3.backgroundColor = UIColorMake(222, 234, 214);
    [button3 setImage:[UIImage imageNamed:@"my_ic_coupon"] forState:UIControlStateNormal];
    button3.layer.cornerRadius = 4;
    button3.buttonImagePosition = FSCustomButtonImagePositionBottom;
    button3.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:button3];
    [button3 sizeToFit];
    
    FSCustomButton *button4 = [[FSCustomButton alloc] initWithFrame:CGRectMake(220, 120, 100, 80)];
    button4.adjustsTitleTintColorAutomatically = YES;
    [button4 setTintColor:UIColorMake(27, 31, 35)];
    button4.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button4 setTitle:@"sizeToFit" forState:UIControlStateNormal];
    button4.backgroundColor = UIColorMake(222, 234, 214);
    [button4 setImage:[UIImage imageNamed:@"my_ic_coupon"] forState:UIControlStateNormal];
    button4.layer.cornerRadius = 4;
    button4.buttonImagePosition = FSCustomButtonImagePositionBottom;
    button4.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.view addSubview:button4];
    [button4 sizeToFit];
    
    FSCustomButton *button5 = [[FSCustomButton alloc] initWithFrame:CGRectMake(100, 220, 200, 40)];
    button5.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button5 setTitle:@"高亮背景色" forState:UIControlStateNormal];
    [button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button5.backgroundColor = UIColorMake(222, 234, 214);
    button5.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
    [button5 setImage:[UIImage imageNamed:@"my_ic_coupon"] forState:UIControlStateNormal];
    button5.layer.cornerRadius = 4;
    button5.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.view addSubview:button5];
    
    FSCustomButton *button6 = [[FSCustomButton alloc] initWithFrame:CGRectMake(100, 280, 200, 40)];
    button6.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button6 setTitle:@"高亮边框色" forState:UIControlStateNormal];
    [button6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button6.backgroundColor = UIColorMake(222, 234, 214);
    button6.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
    [button6 setImage:[UIImage imageNamed:@"my_ic_coupon"] forState:UIControlStateNormal];
    button6.layer.cornerRadius = 4;
    button6.layer.borderWidth = 2;
    button6.highlightedBorderColor = [UIColor redColor];
    button6.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self.view addSubview:button6];
}



@end
