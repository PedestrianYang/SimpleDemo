//
//  ThirdViewController.swift
//  Swift_TableView
//
//  Created by ymq on 16/8/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var _collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        let viewLayout = CustomViewLayout()
        _collectionView = UICollectionView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), collectionViewLayout: viewLayout)
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.backgroundColor = UIColor.clearColor()
        _collectionView.registerClass(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "CellID")
        _collectionView.registerClass(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.view.addSubview(_collectionView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randowColor() -> UIColor{
        let hue = CGFloat(arc4random() % 256) / 256.00
        let saturation = CGFloat(arc4random() % 128) / 256.00 + 0.5
        let brightness = CGFloat(arc4random() % 128) / 256.00 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        let label = cell!.viewWithTag(222) as? UILabel
        self.title = label?.text
        collectionView.reloadData()
        print("\(label!.text)")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 50;
    }
    
    internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath)
        var label = cell.viewWithTag(222) as? UILabel

        if label == nil {
            label = UILabel(frame: CGRectMake(0, 0, 50, 50))
            label!.tag = 222;
            cell.addSubview(label!)
        }
        cell.backgroundColor = self.randowColor()
        label?.text = "\(indexPath.row)"
        return cell
        
    }
    
    //设置sectionheader
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "header", forIndexPath: indexPath) as UICollectionReusableView
            header.backgroundColor = UIColor.redColor()
            return header
        }else{
            return UICollectionReusableView()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
