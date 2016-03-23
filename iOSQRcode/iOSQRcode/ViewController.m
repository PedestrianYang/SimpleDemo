//
//  ViewController.m
//  iOSQRcode
//
//  Created by ymq on 16/3/21.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CustomAlerView.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.bounds = CGRectMake(0, 0, 100, 50);
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    CustomAlerView *alertViewc = [[CustomAlerView alloc] initWithTitle:@"提示" message:@"呵呵" clickAction:nil];
    [self.view addSubview:alertViewc];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startScan
{
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

@end
