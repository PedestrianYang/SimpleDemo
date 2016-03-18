//
//  FoldSectionTableView.m
//  YSWScanViewController
//
//  Created by ymq on 16/3/18.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "FoldSectionTableView.h"
#import "FoldSectionTitleCell.h"

@interface FoldSectionTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *openDic;

@end

@implementation FoldSectionTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        [self setupTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView
{
    self.openDic = [@{@(0):@(NO), @(1):@(YES)} mutableCopy];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = nil;
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    [self registerNib:[UINib nibWithNibName:@"FoldSectionTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FoldSectionTitleCell"];
}

- (void)setTitleArray:(NSArray *)titleArray
{
    for (NSInteger i = 0; i < titleArray.count; i ++)
    {
        [self.openDic setObject:@(NO) forKey:@(i)];
    }
    _titleArray = titleArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSNumber *isOpenNum = [self.openDic objectForKey:@(section)];
    BOOL isOpen = isOpenNum.boolValue;
    
    NSArray *rowArray= [self.cellDataDic objectForKey:@(section)];
    NSInteger rows = rowArray.count;
    return isOpen ? rows + 1 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        NSNumber *isOpenNum = [self.openDic objectForKey:@(indexPath.section)];
        BOOL isOpen = isOpenNum.boolValue;
        FoldSectionTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FoldSectionTitleCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = self.titleArray[indexPath.section];
        cell.selectImg.highlighted = isOpen;
        return cell;
    }
    else
    {
        NSArray *array = self.cellDataDic[@(indexPath.section)];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = array[indexPath.row - 1];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        NSNumber *isOpenNum = [self.openDic objectForKey:@(indexPath.section)];
        BOOL isOpen = !isOpenNum.boolValue;
        [self.openDic setObject:[NSNumber numberWithBool:isOpen] forKey:@(indexPath.section)];
        
        FoldSectionTitleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectImg.highlighted = isOpen;
        
        NSUInteger section = indexPath.section;

        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 44;
    }
    else
    {
        if (indexPath.section == 0)
        {
            return 78;
        }
        else
        {
            return 100;
        }
    }
}

@end
