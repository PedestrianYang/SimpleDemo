//
//  CustomCell.swift
//  Swift_TableView
//
//  Created by ymq on 16/3/8.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

typealias clickAction = (_ titleStr: NSString) -> Void

class CustomCell: UITableViewCell
{
    @objc var lab : UILabel!
    @objc var click : clickAction?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCellView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpCellView()
    }

    @objc func setUpCellView ()
    {
        
        
        lab = UILabel.init(frame: CGRect.init(x: 20, y: 50, width: 100, height: 200))
        lab?.backgroundColor = UIColor.red
        self.addSubview(lab!)
        
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.frame = CGRect(x: 10, y: 10, width: 100, height: 40)
        btn.backgroundColor = UIColor.yellow
        
        btn.addTarget(self, action: #selector(btnClik), for: UIControlEvents.touchUpInside)
    
        self.addSubview(btn)
    }
    @objc func btnClik()
    {
        self.click?(self.lab.text! as NSString);
    }
}
