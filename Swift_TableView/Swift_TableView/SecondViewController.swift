//
//  SecondViewController.swift
//  Swift_TableView
//
//  Created by ymq on 16/3/10.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

//定义一个闭包
typealias callBack = (_ string:String)->Void


class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @objc var funObj: callBack?
    var count : Int = 0
    
    @objc var _tableView :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "2"
        self.view.backgroundColor = UIColor.red
        
//        let btn = UIButton(type: UIButtonType.Custom)
//        btn.frame = CGRectMake(20, 100, 100, 20)
//        btn.backgroundColor = UIColor.redColor();
//        btn.addTarget(self, action:#selector(self.btnClick), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(btn)
        // Do any additional setup after loading the view.
        _tableView = UITableView(frame: CGRect(x: 0, y: 64, width: ScreenWith, height: ScreenHeight), style: UITableViewStyle.plain)
        
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.register(CustomCell.classForCoder(), forCellReuseIdentifier: "CELLID")
        self.view.addSubview(_tableView!);
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func btnClick()
    {
        funObj?("111")
        print("click")
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10;
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELLID") as! CustomCell
        cell.lab.text = "\(indexPath.row)"
    
        cell.click = {
            //[unowned self] 标志，防止闭包循环引用，以致界面释放不掉
             [unowned self](titleStr: NSString) -> Void in
            self.count = 0;
              print("\(titleStr) \(indexPath.row)")
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let secondVC = SecondViewController()
        //---1----
//                secondVC.funObj = {
//                    (string:String)->Void in
//                    print("\(string,self.title)")
//                };
        //---2---
//        secondVC.funObj = self.secondCallback
//        self.navigationController?.pushViewController(secondVC, animated: true)
        
        let thirdVC = ThirdViewController()
        self.navigationController?.pushViewController(thirdVC, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        cell?.isSelected = false
        
    }
    
    @objc func secondCallback(string:String) -> Void{
        print("\(string,self.title)")
    }
    

    
    
    //对象释放时调用
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
