//
//  FileCollectionViewFlowLayout.m
//  LSYReader
//
//  Created by ymq on 2017/12/14.
//  Copyright © 2017年 okwei. All rights reserved.
//

#import "FileCollectionViewFlowLayout.h"

@interface FileCollectionViewFlowLayout()

@property (nonatomic, strong) NSMutableArray *layoutAttributes;
@property (nonatomic, assign) CGFloat maxY;

@end

@implementation FileCollectionViewFlowLayout

- (NSArray *)layoutAttributes
{
    if (!_layoutAttributes){
        _layoutAttributes = [NSMutableArray array];
    }
    return _layoutAttributes;
}

- (void)prepareLayout
{
    [self.layoutAttributes removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i ++)
    {
        [self.layoutAttributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
}

//系统调用方法，设置collectionView滚动区域
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, self.maxY + 10);
}

//设置每一个cell的坐标大小，需要手动调用
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat with = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    
    switch (indexPath.section) {
        case 0:
        {
            
            with = [UIScreen mainScreen].bounds.size.width / 3.0;
            height = with;
            y = indexPath.row / 3 * height;
            if (indexPath.row % 3 == 0) {
                x = 0;
            }else{
                x = (indexPath.row % 3) * with;
            }
        }
            break;

            
        default:
            break;
    }
    
    
    attributes.frame = CGRectMake(x, y, with, height);
    if (self.maxY < CGRectGetMaxY(attributes.frame))
    {
        self.maxY = CGRectGetMaxY(attributes.frame);
    }
    return attributes;
}


//系统调用方法
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.layoutAttributes;
}


@end
