//
//  YSWCarousel.m
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWCarousel.h"

@interface YSWCarousel()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation YSWCarousel

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
        self.pagingEnabled = YES;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self reloadData];
    [self setContentOffset:CGPointMake(0 ,SCREENBOUDENCE.width * 2)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.contentOffset.y > 0)
    {
        if (self.contentOffset.y >= SCREENBOUDENCE.width * (self.dataArray.count + 2))
        {
            [self setContentOffset:CGPointMake(0, SCREENBOUDENCE.width * 2)];
        }
        else if (self.contentOffset.y <= SCREENBOUDENCE.width)
        {
            [self setContentOffset:CGPointMake(0, SCREENBOUDENCE.width * (self.dataArray.count + 1))];
        }
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count == 1 ? 1 : self.dataArray.count + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
    
    UIImageView *imageView = [cell viewWithTag:4];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENBOUDENCE.width, 100)];
        imageView.tag = 4;
        [cell addSubview:imageView];
    }
    
    UIColor *color = nil;

    
    UILabel *label = [cell viewWithTag:5];
    if (!label)
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        label.tag = 5;
        label.textColor = [UIColor yellowColor];
        label.font = [UIFont systemFontOfSize:16];
        [cell addSubview:label];
    }
    
    
    NSInteger page = 0;
    if (indexPath.row == 0)
    {
        page = self.dataArray.count - 1;
        color = self.dataArray[self.dataArray.count - 2];
    }
    else if (indexPath.row == 1)
    {
        page = self.dataArray.count;
        color = self.dataArray[self.dataArray.count - 1];
    }
    else if (indexPath.row - 2 == self.dataArray.count)
    {
        page = 1;
        color = self.dataArray[0];
    }
    else if (indexPath.row - 2 == self.dataArray.count + 1)
    {
        page = 2;
        color = self.dataArray[1];
    }
    else
    {
        page = indexPath.row - 1;
        color = self.dataArray[indexPath.row - 2];
    }

    imageView.backgroundColor = color;
    label.text = [NSString stringWithFormat:@"%@",@(page)];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENBOUDENCE.width;
}
@end
