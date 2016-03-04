//
//  YSWHomeFourAdBigOneCell.m
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWHomeFourAdBigOneCell.h"

@implementation YSWHomeFourAdBigOneCell

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
    [self.thirdImage setImageWithUrl:nil placeholderImage:nil WithData:dataArray[2] tapBlock:^(id obj) {
        if (bself.click)
        {
            bself.click(obj);
        }
    }];
    [self.fourthImage setImageWithUrl:nil placeholderImage:nil WithData:dataArray[3] tapBlock:^(id obj) {
        if (bself.click)
        {
            bself.click(obj);
        }
    }];
}

@end
