//
//  ViewController.m
//  UncaughtExceptionHandlerDemo
//
//  Created by ymq on 16/4/12.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 40, 100, 20);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
}

- (void)btnClick
{
    NSArray *array = @[@"asdqwdq"];
    NSLog(@"%@", array[1]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
