//
//  YSWHomeBtnsCell.m
//  Collection
//
//  Created by ymq on 16/3/2.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWHomeBtnsCell.h"

#define BUTTONTAG 1010101
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation YSWHomeBtnsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews
{
    CGFloat orgY = 0;
    
    CGFloat scale = SCREEN_WIDTH / 360.0;
    
    for (NSInteger i = 0; i < 8; i ++)
    {
        CGFloat btnW = SCREEN_WIDTH / 4.0;
        CGFloat btnH = SCREEN_WIDTH / 4.0;
        CGFloat btnX = i % 4 * btnW;
        CGFloat btnY = (i / 4) * btnH + orgY;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = BUTTONTAG + i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(btnW / 4.0, 14 * scale, btnW / 2.0, btnW / 2.0)];
        imageView.tag = 10;
        [btn addSubview:imageView];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 3, btnW, 20)];
        label.tag = 11;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1];
        [btn addSubview:label];
        
        
        [self addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - BUTTONTAG;
    if (self.click)
    {
        self.click(self.dataArray[index]);
    }
}


- (void)setDataArray:(NSArray *)dataArray
{
    [super setDataArray:dataArray];
    for (NSInteger i = 0; i < 8; i ++)
    {
        UIButton *btn = [self viewWithTag:BUTTONTAG + i];
        UIImageView *imageView = [btn viewWithTag:10];
        imageView.backgroundColor = [UIColor colorWithRed:0.1 * i green:0.1 * i blue:0.1 * i alpha:0.1 * i];
        UILabel *label = [btn viewWithTag:11];
        label.text = dataArray[i];
    }
}

@end
