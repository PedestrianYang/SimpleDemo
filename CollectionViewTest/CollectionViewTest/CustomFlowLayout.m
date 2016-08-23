//
//  CustomFlowLayout.m
//  CollectionViewTest
//
//  Created by ymq on 16/8/4.
//  Copyright © 2016年 ymq. All rights reserved.
//

#import "CustomFlowLayout.h"



@interface CustomFlowLayout ()

@property (nonatomic, strong) NSMutableArray *layoutAttributes;
@property (nonatomic, assign) CGFloat maxY;

@end

@implementation CustomFlowLayout


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
            height = 50;
            with = [UIScreen mainScreen].bounds.size.width / 2.0;
            if (indexPath.row % 3 != 2)
            {
                NSInteger count = indexPath.row / 3;
                y = height * count * 2;
            }
            else
            {
                NSInteger count = indexPath.row / 3;
                y = height * count * 2 + height;
            }
            
            if (indexPath.row % 3 == 0)
            {
                x = 0;
                height = 100;
            }
            else
            {
                x = with;
                height = 50;
            }
        }
            break;
        case 1:
        {
            
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
