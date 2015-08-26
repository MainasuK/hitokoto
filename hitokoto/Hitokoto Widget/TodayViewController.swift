//
//  TodayViewController.swift
//  Hitokoto Widget
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import UIKit
import NotificationCenter
import HitokotoDataKit

class TodayViewController: HitokotoViewController, NCWidgetProviding {
    var format = "charset=utf-8"
    
    var lastHitokoto: String?
    var lastSource: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        if let hitokoto = NSUserDefaults.standardUserDefaults().valueForKey("lastHitokoto") as? String {
            lastHitokoto = hitokoto
        }
        if let source = NSUserDefaults.standardUserDefaults().valueForKey("lastSource") as? String {
            lastSource = source
        }
        
        if lastHitokoto != nil {
            self.hitokotoLabel.text = lastHitokoto
        }
        if lastSource != nil {
            self.sourceLabel.text = lastSource
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        getHitokotoData(format, completion: { (error) -> () in
            if error == nil {
                self.updateDataExtension()
                self.lastHitokoto = self.hitokotoLabel.text
                self.lastSource = self.sourceLabel.text
                NSUserDefaults.standardUserDefaults().setValue(self.lastHitokoto, forKey: "lastHitokoto")
                NSUserDefaults.standardUserDefaults().setValue(self.lastSource, forKey: "lastSource")
                NSUserDefaults.standardUserDefaults().synchronize()
                completionHandler(.NewData)
            } else {
                completionHandler(.NoData)
            }
        })
            
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
