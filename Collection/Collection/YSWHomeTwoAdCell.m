//
//  YSWHomeTwoAdCell.m
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWHomeTwoAdCell.h"

@implementation YSWHomeTwoAdCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArray:(NSArray *)dataArray
{
    [super setDataArray:dataArray];
    __weak typeof(self)bself = self;
    [self.firstImage setImageWithUrl:nil placeholderImage:nil WithData:dataArray[0] tapBlock:^(id obj) {
        if (bself.click)
        {
            bself.click(obj);
        }
    }];
    [self.secondImage setImageWithUrl:nil placeholderImage:nil WithData:dataArray[1] tapBlock:^(id obj) {
        if (bself.click)
        {
            bself.click(obj);
        }
    }];
}

@end
