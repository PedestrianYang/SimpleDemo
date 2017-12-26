//
//  CustomTableViewCell.swift
//  Swift_Sound
//
//  Created by 云书网 on 2017/12/26.
//  Copyright © 2017年 ymq. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var namel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentLab.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
