//
//  ViewController.swift
//  SwiftHttpRequestDemo
//
//  Created by ymq on 16/8/24.
//  Copyright © 2016年 ymq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let url = "http://218.28.35.139:8001/IyunshuApp/yunshu/selectHomepage_NEW"
        let date = NSDate(timeIntervalSinceNow: 0)
        let timeInterval = date.timeIntervalSince1970 * 1000
        let timeStr = String(format: "%.0f", timeInterval)
        
        let parameters = NSMutableDictionary()
        parameters.setObject("3.4.0", forKey: "build")
        parameters.setObject("1", forKey: "device")
        parameters.setObject(timeStr, forKey: "time")
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/plain", "text/json", "application/json","text/javascript","text/html", "application/javascript", "text/js") as? Set<String>
        
        manager.POST(url, parameters: parameters, progress: { (progress: NSProgress) in
            
            }, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
                print(response)
        }) { (task: NSURLSessionDataTask?, error: NSError) in
                print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

