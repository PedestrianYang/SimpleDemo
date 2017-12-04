//
//  ThirdViewController.swift
//  Swift_TableView
//
//  Created by ymq on 16/8/9.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @objc var _collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        let viewLayout = CustomViewLayout()
        _collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWith, height: ScreenHeight), collectionViewLayout: viewLayout)
        _collectionView.delegate = self
        _collectionView.dataSource = self
        _collectionView.backgroundColor = UIColor.clear
        _collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "CellID")
        _collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.view.addSubview(_collectionView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func randowColor() -> UIColor{
        let hue = CGFloat(arc4random() % 256) / 256.00
        let saturation = CGFloat(arc4random() % 128) / 256.00 + 0.5
        let brightness = CGFloat(arc4random() % 128) / 256.00 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let label = cell!.viewWithTag(222) as? UILabel
        self.title = label?.text
        collectionView.reloadData()
        print(label!.text ?? "无值")
    }
    
    @objc func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 50;
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        var label = cell.viewWithTag(222) as? UILabel

        if label == nil {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            label!.tag = 222;
            cell.addSubview(label!)
        }
        cell.backgroundColor = self.randowColor()
        label?.text = "\(indexPath.row)"
        return cell
        
    }
    
    //设置sectionheader
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as UICollectionReusableView
            header.backgroundColor = UIColor.red
            return header
        }else{
            //不可返回nil
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
