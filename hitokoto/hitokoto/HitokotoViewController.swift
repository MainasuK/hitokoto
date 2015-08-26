//
//  HitokotoViewController.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-7.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import UIKit

public class HitokotoViewController: UIViewController {

    @IBOutlet public weak var hitokotoLabel: UILabel!
    @IBOutlet public weak var authorLabel: UILabel!
    @IBOutlet public weak var likeLabel: UILabel!
    @IBOutlet public weak var dateLabel: UILabel!
    @IBOutlet public weak var catnameLabel: UILabel!
    @IBOutlet public weak var idLabel: UILabel!
    @IBOutlet public weak var sourceLabel: UILabel!
    
    public var hitokotoData: HitokotoData?
    
    public func updateData() {
        if let unwrappedHD = hitokotoData {
            self.hitokotoLabel.text = "\(unwrappedHD.hitokoto)"
            self.authorLabel.text = "投稿人：\(unwrappedHD.author)"
            self.likeLabel.text = "Like：\(unwrappedHD.like)"
            self.dateLabel.text = "投稿日期：\(unwrappedHD.date)"
            self.catnameLabel.text = "\(unwrappedHD.catname)"
            self.idLabel.text = "ID：\(unwrappedHD.id)"
            
            let source = unwrappedHD.source
            if source != "" {
                self.sourceLabel.text = "出自：\(unwrappedHD.source)"
            } else {
                self.sourceLabel.text = "未知出处"
            }
        }
    }
    
    public func updateDataExtension() {
        if let unwrappedHD = hitokotoData {
            self.hitokotoLabel.text = "\(unwrappedHD.hitokoto)"
            NSUserDefaults.standardUserDefaults().setValue(self.hitokotoLabel.text, forKey: "hitokotoLabel")
            let source = unwrappedHD.source
            if source != "" {
                self.sourceLabel.text = "出自：\(unwrappedHD.source)"
            } else {
                self.sourceLabel.text = "未知出处"
            }
            NSUserDefaults.standardUserDefaults().setValue(self.sourceLabel.text, forKey: "sourceLabel")
        }
    }
    
    public func getHitokotoData(format: String, completion: (error: NSError?) -> ()) {
        HitokotoService.sharedInstance.fetchHitokotoData(format, completion: { (data, error) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                self.hitokotoData = data
                completion(error: error)
            }
        })
    }

}

