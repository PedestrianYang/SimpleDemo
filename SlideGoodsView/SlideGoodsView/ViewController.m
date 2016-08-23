//
//  ViewController.m
//  SlideGoodsView
//
//  Created by ymq on 16/7/20.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "YSWHomeSlideGoodsCell.h"
#import "MJRefresh.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"5252525");
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"YSWHomeSlideGoodsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeSlideGoodsCell"];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"11111");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YSWHomeSlideGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YSWHomeSlideGoodsCell"];
    [cell setupContaintData:@[@"1111",@"222",@"222",@"222",@"222",@"222"]];
    return cell;
}

@end
