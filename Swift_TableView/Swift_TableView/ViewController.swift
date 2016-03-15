//
//  ViewController.swift
//  Swift_TableView
//
//  Created by ymq on 16/3/10.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

let ScreenWith = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var _tableView :UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "1"
        _tableView = UITableView(frame: CGRectMake(0, 100, ScreenWith, ScreenHeight - 100), style: UITableViewStyle.Plain)
        _tableView!.delegate = self
        _tableView!.dataSource = self
        _tableView!.registerClass(CustomCell.classForCoder(), forCellReuseIdentifier: "CELLID")
        self.view.addSubview(_tableView!);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CELLID") as! CustomCell
        cell.lab.text = "\(indexPath.row)"
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let secondVC = SecondViewController()
        secondVC.initWithfunObj(callBack)
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func callBack(sting : String) -> Void
    {
        print("\(sting)")
    }
}
