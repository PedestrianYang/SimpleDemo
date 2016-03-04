//
//  YSWHomeBannerAdCell.m
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWHomeBannerAdCell.h"

@implementation YSWHomeBannerAdCell

- (void)awakeFromNib {
    // Initialization code
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
}

@end
