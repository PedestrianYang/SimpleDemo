//
//  CustomViewLayout.swift
//  Swift_TableView
//
//  Created by ymq on 16/8/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

class CustomViewLayout: UICollectionViewLayout {
    
    var _layoutAttributes : [UICollectionViewLayoutAttributes]?
    
    override func prepareLayout() {
        
        if _layoutAttributes == nil {
            _layoutAttributes = []
        }else{
            _layoutAttributes?.removeAll()
        }
        
        let sections = self.collectionView?.numberOfSections()
        
        for section in 0...(sections! - 1) {
            let rows = self.collectionView?.numberOfItemsInSection(section)
            _layoutAttributes?.append(self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: NSIndexPath(forRow: 0, inSection: section))!)
            for row in 0...(rows! - 1) {
                _layoutAttributes?.append(self.layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: row, inSection: section))!)
            }
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        var width : CGFloat = 0.0
        var height: CGFloat = 50.0
        var x: CGFloat = 0.0
        var y: CGFloat = 20.0
        
        if  indexPath.section != 0 {
            y = self.getMaxY(indexPath.section - 1) + CGFloat(20)
        }
        
        let screenWith = UIScreen.mainScreen().bounds.size.width
        width = CGFloat(screenWith) / CGFloat(2.0)
        
        if indexPath.row % 4 < 2 {
            let count = indexPath.row / 4;
            y += height * CGFloat(count) * 2;
        }else{
            let count = indexPath.row / 4;
            y += height * CGFloat(count) * 2 + height;
        }
        
        switch indexPath.row % 4 {
        case 0:
            x = 0;
            height = 100;
            break
        case 1:
            x = width;
            height = 50;
            break
        case 2:
            x = width;
            height = 50;
            width = width / 2.0
            break
        case 3:
            x = width / 2.0 + width;
            height = 50;
            width = width / 2.0
            break
        default:
            break
        }
        
        attributes.frame = CGRectMake(x, y, width, height)
        
        return attributes
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        let y = indexPath.section == 0 ? CGFloat(0) : self.getMaxY(indexPath.section - 1)
        
        attributes.frame = CGRectMake(0, y, UIScreen.mainScreen().bounds.size.width, 20)
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return _layoutAttributes
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(0, self.getMaxY((self.collectionView?.numberOfSections())! - 1))
    }

    //使用自定义layout，需要确定每一个cell的坐标，即不同section时，需要获取上一个scetion的最底层cell的坐标
    func getMaxY(section: NSInteger) -> CGFloat {
        let tempArray = _layoutAttributes! as NSArray
        var maxHeight = CGFloat(0.0)
        
        tempArray.enumerateObjectsUsingBlock { (tempattributes, index, stop) in
            let tempattributesaa = tempattributes as! UICollectionViewLayoutAttributes
            if tempattributesaa.indexPath.section == section
            {
                let maxY = CGRectGetMaxY(tempattributesaa.frame)
                if maxY > maxHeight {
                    maxHeight = maxY
                }
            }
        }
        
        return maxHeight
    }
}
