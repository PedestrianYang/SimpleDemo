//
//  YSWHomeBaseCell.m
//  Collection
//
//  Created by ymq on 16/3/2.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWHomeBaseCell.h"

@implementation YSWHomeBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
