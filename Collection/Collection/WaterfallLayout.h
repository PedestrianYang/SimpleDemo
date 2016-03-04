//
//  WaterfallLayout.h
//  Collection
//
//  Created by ymq on 16/2/26.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat(^HeightBlock)(NSIndexPath *indexPath , CGFloat width);
@interface WaterfallLayout : UICollectionViewLayout
/** 列数 */
@property (nonatomic, assign) NSInteger lineNumber;
/** 行间距 */
@property (nonatomic, assign) CGFloat rowSpacing;
/** 列间距 */
@property (nonatomic, assign) CGFloat lineSpacing;
/** 内边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;
/**
    12  *  计算各个item高度方法 必须实现
    13  *
    14  *  @param block 设计计算item高度的block
    15  */
- (void)computeIndexCellHeightWithWidthBlock:(CGFloat(^)(NSIndexPath *indexPath , CGFloat width))block;

@end
