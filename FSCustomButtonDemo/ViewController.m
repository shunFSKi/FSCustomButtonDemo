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
    FSCustomButton *button = [[FSCustomButton alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
//    button.adjustsButtonWhenHighlighted = YES;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitle:@"哈哈哈哈哈" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    button.backgroundColor = UIColorMake(43, 133, 208);;
//    button.highlightedBackgroundColor = UIColorMake(0, 168, 225);// 高亮时的背景色
    button.layer.cornerRadius = 4;
//    button.layer.borderColor = [UIColor redColor].CGColor;
//    button.layer.borderWidth = 1;
//    button.highlightedBorderColor = [UIColor blackColor];
    [self.view addSubview:button];
}


@end
