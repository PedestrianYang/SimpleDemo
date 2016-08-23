//
//  YSWHomeSlideGoodsCell.m
//  SlideGoodsView
//
//  Created by ymq on 16/7/20.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "YSWHomeSlideGoodsCell.h"
#import "YSWHomeSlideGoodsView.h"

@implementation YSWHomeSlideGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgScrollView.showsVerticalScrollIndicator = NO;
    _bgScrollView.showsHorizontalScrollIndicator = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupContaintData:(NSArray *)data
{
    for (NSInteger i = 0; i < data.count; i ++)
    {
        YSWHomeSlideGoodsView *view = [self.bgScrollView viewWithTag:1086 + i];
        if (!view)
        {
            CGFloat scale = SCREEN_WIDTH / 1080.0;
            CGFloat width = SCREEN_WIDTH / 3.5;
            CGFloat height = 290 * scale;
            CGFloat goosViewX = i * width;
            view = [[[NSBundle mainBundle] loadNibNamed:@"YSWHomeSlideGoodsView" owner:self options:nil] lastObject];
            view.frame = CGRectMake(goosViewX, 0, width, height);
            view.tag = 1086 + i;
            [self.bgScrollView addSubview:view];
            _bgScrollView.contentSize = CGSizeMake(CGRectGetMaxX(view.frame), 0);
        }
    }
    
}

@end
