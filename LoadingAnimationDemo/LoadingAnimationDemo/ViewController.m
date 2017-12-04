//
//  ViewController.m
//  LoadingAnimationDemo
//
//  Created by ymq on 16/9/7.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "UIView+UIView_Loading.h"
#import "YSWFindNewVersionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YSWFindNewVersionView *view = [[YSWFindNewVersionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view showForView:self.view WithType:FindNewVerAlertTypeForce WithInfo:@"1sadasdsdsadaadsaddwqerqwerqwerqwerqwerqwerqwerqwerqwerwqerqwas\n2ddasdasdasdasdasdasda\n3dasadsdasdasdadasdad\n1sadadsdasdasdasdas\n2dasdasdaasdasdsasdasdqwwdqedfqwdqwasda\n1sadasdas\n2dadsdasdasdasda\n3dasdasdad\n1sadasdas\n2dasdasda\n3dasdasdad\n1sadasdasddasdas\n2dasdasda\n3dasdasdad\n"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.view startLoading];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
