//
//  SecondViewController.swift
//  Swift_TableView
//
//  Created by ymq on 16/3/10.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

//定义一个闭包
typealias callBack = (string:String)->Void


class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var funObj: callBack?
    var _tableView :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "2"
        self.view.backgroundColor = UIColor.whiteColor()
        let btn = UIButton(type: UIButtonType.Custom)
        btn.frame = CGRectMake(20, 100, 100, 20)
        btn.backgroundColor = UIColor.redColor();
        btn.addTarget(self, action:"btnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
        
        _tableView = UITableView(frame: CGRectMake(0, 100, ScreenWith, ScreenHeight - 100), style: UITableViewStyle.Plain)
        _tableView!.delegate = self
        _tableView!.dataSource = self
        _tableView!.registerClass(CustomCell.classForCoder(), forCellReuseIdentifier: "CELLID")
        self.view.addSubview(_tableView!);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func btnClick()
    {
        funObj?(string: "111")
        print("click")
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CELLID") as! CustomCell
        cell.lab.text = "\(indexPath.row)"
    
        cell.click = {
            //[unowned self] 标志，防止闭包循环引用，以致界面释放不掉
             [unowned self] (titleStr: NSString) -> Void in
            print("\(titleStr,self.title) \(indexPath.row)")
        }
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let secondVC = SecondViewController()
        secondVC.funObj = {
            (string:String)->Void in
            print("\(string,self.title)")
        };
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    deinit{
        print("界面释放")
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
