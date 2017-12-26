//
//  ViewController.swift
//  Swift_Sound
//
//  Created by ymq on 2017/12/1.
//  Copyright © 2017年 ymq. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVSpeechSynthesizerDelegate, GCDWebUploaderDelegate, UITableViewDelegate, UITableViewDataSource{
    var av: AVSpeechSynthesizer!
    var utterance : AVSpeechUtterance!
    var webServer : GCDWebUploader!
    
    @IBOutlet weak var tableView: UITableView!
    var dataArry : NSArray!
    var prototypeCell : CustomTableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.register(UINib.init(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cellid")
        tableView.estimatedRowHeight = 100
        prototypeCell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! CustomTableViewCell
        
//        let button: UIButton = UIButton(type: UIButtonType.custom)
//        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
//        button.setTitle("讲", for: UIControlState.normal)
//        button.setTitle("停", for: UIControlState.selected)
//        button.setTitleColor(UIColor.blue, for: UIControlState.normal)
//        button.backgroundColor = UIColor.gray
//        button.showsTouchWhenHighlighted = true
//        button.addTarget(self, action: #selector(start(btn:)), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(button)
        
//        setupAVPlayer()
        dataArry = ["锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。","锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。","锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。","锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。","锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。",]
//        utterance = AVSpeechUtterance(string: "锦瑟无端五十弦，一弦一柱思华年。庄生晓梦迷蝴蝶，望帝春心托杜鹃。沧海月明珠有泪，蓝田日暖玉生烟。此情可待成追忆，只是当时已惘然。")
//        utterance.rate = 0.5
//        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
//        utterance.voice = voice
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterreption(sender:)), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        
//        setupService();
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webServer.stop()
    }
    
    func setupService() -> Void {
    
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        webServer = GCDWebUploader(uploadDirectory: documentsPath!)
        
        webServer.delegate = self
        
        webServer.allowHiddenItems = true
        
        if webServer.start() {
            let ipString = getLocalIPAddressForCurrentWiFi()
            let port = webServer.port
            print(ipString! + String(port))
        }
        
    }
    
    
    func getLocalIPAddressForCurrentWiFi() -> String? {
        var address: String?
        
        // get list of all interfaces on the local machine
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        guard getifaddrs(&ifaddr) == 0 else {
            return nil
        }
        guard let firstAddr = ifaddr else {
            return nil
        }
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            
            let interface = ifptr.pointee
            
            // Check for IPV4 or IPV6 interface
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                // Check interface name
                let name = String(cString: interface.ifa_name)
                if name == "en0" {
                    
                    // Convert interface address to a human readable string
                    var addr = interface.ifa_addr.pointee
                    var hostName = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostName, socklen_t(hostName.count), nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostName)
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return address
    }

    
    
    @objc func handleInterreption(sender: NSNotification) -> Void {
        if av.isSpeaking {
            av.pauseSpeaking(at: AVSpeechBoundary.word)
        }else{
            av.continueSpeaking()
        }
    }
    
    func setupAVPlayer() -> Void {
        av = AVSpeechSynthesizer()
        av.delegate = self
        
    }
    
    func readWithString(content: String) -> Void {
        utterance = AVSpeechUtterance(string: content)
        utterance.rate = 0.5
        let voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.voice = voice
        
        av.speak(utterance)
    }
    
    
    
    @objc func start(btn: UIButton) -> Void {
        if !btn.isSelected {
            if av != nil && av.isPaused{
                av.continueSpeaking()
                
            }else{
               
                av.speak(utterance)
            }
        }else{
            av.pauseSpeaking(at: AVSpeechBoundary.word)
        }
        btn.isSelected = !btn.isSelected
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ------------ UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count;
    }
    
    // MARK: ------------UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! CustomTableViewCell
        cell.contentLab.text = dataArry.object(at: indexPath.row) as? String
        cell.namel.text = "\(indexPath.row)"
        return cell
    }
    
    
    //若要使用systemLayoutSizeFitting自适应高度，需要cell的xib文件中设置约束
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        prototypeCell.contentLab.text = dataArry.object(at: indexPath.row) as? String
        
        let widthFenceConstraint = NSLayoutConstraint(item: prototypeCell.contentView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0, constant: tableView.bounds.size.width - 20)
        prototypeCell.contentView.addConstraint(widthFenceConstraint)
        
        let fittingHeight = prototypeCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        prototypeCell.contentView.removeConstraint(widthFenceConstraint)
        
        return fittingHeight + 2*1/UIScreen.main.scale
    }
    
    // MARK: ------------GCDWebUploaderDelegate
    func webUploader(_ uploader: GCDWebUploader, didUploadFileAtPath path: String) {
        print("[UPLOAD]->" + path)
    }
    
    func webUploader(_ uploader: GCDWebUploader, didMoveItemFromPath fromPath: String, toPath: String) {
        print("[MOVE]->" + fromPath)
    }
    
    func webUploader(_ uploader: GCDWebUploader, didCreateDirectoryAtPath path: String) {
        print("[CREATE]->" + path)
    }
    
    // MARK: ------------AVSpeechSynthesizerDelegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        print("暂停")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("开始")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        print("取消")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("结束")
        readWithString(content: "呵呵呵呵呵呵aaaaa")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        print("继续")
    }
    
    
    override func remoteControlReceived(with event: UIEvent?) {
        switch event!.subtype {
        case .remoteControlPlay:  // play按钮
            if av != nil && av.isPaused{
                av.continueSpeaking()
            }else{
                av.speak(utterance)
            }
        case .remoteControlPause:  // pause按钮
             av.pauseSpeaking(at: AVSpeechBoundary.word)
        case .remoteControlNextTrack:  // next
            // ▶▶
            break
        case .remoteControlPreviousTrack:  // previous
            // ◀◀
            break
        default:
            break
        }
    }

}

