//
//  ViewController.m
//  FoldSectonTableViewDemo
//
//  Created by ymq on 16/3/18.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "FoldSectionTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDictionary *cellDataDic = @{@(0):@[@"这是一区",@"这是一区",@"这是一区",@"这是一区"], @(1):@[@"这是二区",@"这是二区",@"这是二区"], @(2):@[@"这是三区",@"这是三区",@"这是三区"]} ;
    NSArray *titleArray = @[@"一区:", @"二区", @"三区"];
   
    
    FoldSectionTableView *tableView = [[FoldSectionTableView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.cellDataDic = cellDataDic;
    tableView.titleArray = titleArray;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
