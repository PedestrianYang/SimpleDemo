//
//  ViewController.m
//  RunTimeTest
//
//  Created by ymq on 16/3/8.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "People.h"
#import "Man.h"
#import "Woman.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"1";
    Man *man = [[Man alloc] init];
    man.name = @"aaa";
    man.age = 20;;
    man.man = YES;
    
    Woman *woman = [[Woman alloc] init];
    woman.name = @"nnn";
    woman.age = 18;
    woman.man = NO;
    
    
    man.wife = woman;
    NSLog(@"%@",man);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
