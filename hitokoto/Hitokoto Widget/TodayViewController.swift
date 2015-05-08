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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.

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
