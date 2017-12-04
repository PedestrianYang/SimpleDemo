//
//  ViewController.swift
//  Swift_TableView
//
//  Created by ymq on 16/3/10.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit



let ScreenWith = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    /*"!"表示一定有值 "?"表示不一定有值 在闭包传值中使用"?"可以不用判断该闭包是否为空 如果使用"!"则必须判断是否为空，否则会崩溃*/
    @objc var _tableView :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "1"
        
        _tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWith, height: ScreenHeight), style: UITableViewStyle.plain)

        _tableView!.delegate = self
        _tableView!.dataSource = self
        _tableView!.register(CustomCell.classForCoder(), forCellReuseIdentifier: "CELLID")
        self.view.addSubview(_tableView!);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as! CustomCell
        cell.lab.text = "\(indexPath.row)"
        cell.click = {
            (titleStr: NSString) -> Void in
            print("\(titleStr) \(indexPath.row)")
        }
        return cell;
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondVC = SecondViewController()
        secondVC.funObj = {
            (string:String)->Void in
            print("\(string)")
        };
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

}
