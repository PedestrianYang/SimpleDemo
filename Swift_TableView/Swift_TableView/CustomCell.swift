//
//  CustomCell.swift
//  Swift_TableView
//
//  Created by ymq on 16/3/8.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell
{
    var lab : UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpCellView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpCellView()
    }
    
    
    func setUpCellView ()
    {
        lab = UILabel.init(frame: CGRectMake(20, 50, 100, 200))
        lab?.backgroundColor = UIColor.redColor()
        self.addSubview(lab!)
    }
}
