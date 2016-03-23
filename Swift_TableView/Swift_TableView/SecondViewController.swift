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

class SecondViewController: UIViewController {
    var funObj: callBack?
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
