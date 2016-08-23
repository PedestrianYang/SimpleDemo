//
//  YSWHomeSlideGoodsCell.h
//  SlideGoodsView
//
//  Created by ymq on 16/7/20.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSWHomeSlideGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

- (void)setupContaintData:(NSArray *)data;

@end
