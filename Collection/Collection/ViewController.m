//
//  ViewController.m
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "ViewController.h"
#import "YSWHomeBannerAdCell.h"
#import "YSWHomeTwoAdCell.h"
#import "YSWHomeThreeAdBigOneCell.h"
#import "YSWHomeThreeAdCell.h"
#import "YSWHomeFourAdBigOneCell.h"
#import "YSWHomeFourAdCell.h"
#import "YSWHomeBannerTwoAdCell.h"
#import "YSWHomeBaseCell.h"
#import "YSWHomeBtnsCell.h"
#import "YSWCarousel.h"

#define SCREENBOUDENCE [UIScreen mainScreen].bounds.size

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) NSMutableArray *btnSection;
@property (nonatomic, retain) NSMutableArray *sectionOne;
@property (nonatomic, retain) NSMutableArray *sectionTwo;
@property (nonatomic, retain) NSMutableArray *sectionThree;
@property (nonatomic, retain) NSMutableArray *sectionFour;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    YSWCarousel *carousel = [[YSWCarousel alloc] initWithFrame:CGRectMake(0, 0, 100, SCREENBOUDENCE.width) style:UITableViewStylePlain];
    
    carousel.dataArray = @[[UIColor redColor], [UIColor orangeColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], [UIColor blackColor], [UIColor purpleColor]];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENBOUDENCE.width, SCREENBOUDENCE.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;

    
    _tableView.tableHeaderView = carousel;
    
    [_tableView registerClass:[YSWHomeBtnsCell class] forCellReuseIdentifier:@"YSWHomeBtnsCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeBannerTwoAdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeBannerTwoAdCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeBannerAdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeBannerAdCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeTwoAdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeTwoAdCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeThreeAdBigOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeThreeAdBigOneCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeThreeAdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeThreeAdCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeFourAdBigOneCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeFourAdBigOneCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"YSWHomeFourAdCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"YSWHomeFourAdCell"];
    
    [self.view addSubview:_tableView];
    
    self.dataArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < 31; i ++)
    {
        [self.dataArray addObject:[NSString stringWithFormat:@"%@",@(i)]];
    }
    
    
    
    NSMutableArray *tempArray = [@[] mutableCopy];
    
    for (NSInteger i = 0; i < 9; i ++)
    {
        [tempArray addObject:self.dataArray[i]];
    }
    self.btnSection = tempArray;
    
    
    for (NSInteger i = 0; i < 9; i ++)
    {
        [tempArray addObject:self.dataArray[i]];
    }
    self.sectionOne = tempArray;
    
    tempArray = [@[] mutableCopy];
    for (NSInteger i = 9; i < 15; i ++)
    {
        [tempArray addObject:self.dataArray[i]];
    }
    self.sectionTwo = tempArray;
    
    tempArray = [@[] mutableCopy];
    for (NSInteger i = 15; i < 27; i ++)
    {
        [tempArray addObject:self.dataArray[i]];
    }
    self.sectionThree = tempArray;
    
    tempArray = [@[] mutableCopy];
    for (NSInteger i = 27; i < 31; i ++)
    {
        [tempArray addObject:self.dataArray[i]];
    }
    self.sectionFour = tempArray;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section)
    {
        case 0:
        {
            rows = 1;
        }
            break;
        case 1:
        {
            rows = 4;
        }
            break;
        case 2:
        {
            rows = 3;
        }
            break;
        case 3:
        {
            rows = 4;
        }
            break;
        case 4:
        {
            rows = 4;
        }
            break;
            
        default:
            break;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YSWHomeBaseCell *cell = nil;
    
    NSString *cellID = @"";
    switch (indexPath.section)
    {
        case 0:
        {
            cellID = @"YSWHomeBtnsCell";
            YSWHomeBtnsCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
            [tempCell setDataArray:_btnSection];
            cell = tempCell;
        }
            break;
        case 1:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cellID = @"YSWHomeBannerTwoAdCell";
                    YSWHomeBannerTwoAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    tempCell.secondImage.backgroundColor = [UIColor blackColor];
                    [tempCell setDataArray:@[_sectionOne[0],_sectionOne[1]]];
                    
                    cell = tempCell;
                   
                }
                    break;
                case 1:
                {
                    cellID = @"YSWHomeThreeAdBigOneCell";
                    YSWHomeThreeAdBigOneCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    tempCell.secondImage.backgroundColor = [UIColor blackColor];
                    tempCell.thirdImage.backgroundColor = [UIColor whiteColor];
                    [tempCell setDataArray:@[_sectionOne[2],_sectionOne[3],_sectionOne[4]]];

                    cell = tempCell;
                }
                    break;
                default:
                {
                    cellID = @"YSWHomeTwoAdCell";
                    YSWHomeTwoAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor orangeColor];
                    tempCell.secondImage.backgroundColor = [UIColor blueColor];
                    NSInteger index = (indexPath.row + 1) * 2;
                    [tempCell setDataArray:@[_sectionOne[index - 1],_sectionOne[index]]];
                    cell = tempCell;
                }
                    break;
            }
        }
            
            break;
            
        case 2:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    
                    cellID = @"YSWHomeBannerAdCell";
                    YSWHomeBannerAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    [tempCell setDataArray:@[_sectionTwo[0]]];
                    cell = tempCell;
                    
                }
                    break;
                case 1:
                {
                    cellID = @"YSWHomeThreeAdBigOneCell";
                    YSWHomeThreeAdBigOneCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    tempCell.secondImage.backgroundColor = [UIColor blackColor];
                    tempCell.thirdImage.backgroundColor = [UIColor whiteColor];
                    [tempCell setDataArray:@[_sectionTwo[1],_sectionTwo[2],_sectionTwo[3]]];
                    cell = tempCell;
                }
                    break;
                default:
                {
                    cellID = @"YSWHomeTwoAdCell";
                    YSWHomeTwoAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor orangeColor];
                    tempCell.secondImage.backgroundColor = [UIColor blueColor];
                    NSInteger index = indexPath.row * 2;
                    [tempCell setDataArray:@[_sectionTwo[index],_sectionTwo[index + 1]]];
                    cell = tempCell;
                }
                    break;
            }
        }
            break;
        case 3:
        {
            switch (indexPath.row)
            {
                
                case 0:
                {
                    cellID = @"YSWHomeBannerAdCell";
                    YSWHomeBannerAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor yellowColor];
                    [tempCell setDataArray:@[_sectionThree[0]]];
                    cell = tempCell;
                }
                    break;
                case 1:
                {
                    cellID = @"YSWHomeFourAdBigOneCell";
                    YSWHomeFourAdBigOneCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    tempCell.secondImage.backgroundColor = [UIColor blackColor];
                    tempCell.thirdImage.backgroundColor = [UIColor whiteColor];
                    tempCell.fourthImage.backgroundColor = [UIColor yellowColor];
                    [tempCell setDataArray:@[_sectionThree[1], _sectionThree[2], _sectionThree[3], _sectionThree[4]]];
                    cell = tempCell;
                }
                    break;
                case 2:
                {
                    cellID = @"YSWHomeFourAdCell";
                    YSWHomeFourAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    tempCell.secondImage.backgroundColor = [UIColor blackColor];
                    tempCell.thirdImage.backgroundColor = [UIColor whiteColor];
                    tempCell.fourthImage.backgroundColor = [UIColor yellowColor];
                    [tempCell setDataArray:@[_sectionThree[5], _sectionThree[6], _sectionThree[7], _sectionThree[8]]];
                    cell = tempCell;
                }
                    break;
                    
                default:
                {
                    cellID = @"YSWHomeThreeAdCell";
                    YSWHomeThreeAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
                    tempCell.firstImage.backgroundColor = [UIColor redColor];
                    tempCell.secondImage.backgroundColor = [UIColor blackColor];
                    tempCell.thirdImage.backgroundColor = [UIColor whiteColor];
                    [tempCell setDataArray:@[_sectionThree[9], _sectionThree[10], _sectionThree[11]]];
                    cell = tempCell;
                }
                    break;
            }
        }
            break;
        case 4:
        {
            cellID = @"YSWHomeBannerAdCell";
            YSWHomeBannerAdCell *tempCell = [tableView dequeueReusableCellWithIdentifier:cellID];
            tempCell.firstImage.backgroundColor = [UIColor yellowColor];
            [tempCell setDataArray:@[_sectionFour[indexPath.row]]];
            cell = tempCell;
        }
            
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.click = ^(id obj)
    {
        NSLog(@"%@",obj);
    };
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0.0;
    CGFloat scale = SCREENBOUDENCE.width / 360.0;
    switch (indexPath.section)
    {
        case 0:
        {
            height = SCREENBOUDENCE.width * 0.5;
        }
            break;
        case 1: case 2: case 3:
        {
            switch (indexPath.row)
            {
                case 0:
                    height = scale * 90;
                    break;
                case 1:
                    height = scale * 200;
                    break;
                case 2: case 3:
                    height = scale * 100;
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 4:
        {
            height = scale * 130;
        }
            break;
            
        default:
            break;
    }
    return height;
}

@end
