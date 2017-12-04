//
//  ViewController.swift
//  SwiftTest
//
//  Created by ymq on 2017/11/24.
//  Copyright © 2017年 ymq. All rights reserved.
//

import UIKit

let SCREENWIDTH : CGFloat = UIScreen.main.bounds.width
let SCREENHEIGHT : CGFloat = UIScreen.main.bounds.height

typealias btnClick = (title:NSString)->Void

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
     var _tableView : UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        cell?.textLabel?.text = "\(indexPath.row)";
        
        return cell!;
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        _tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT));
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellid");
        
        self.view.addSubview(_tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

