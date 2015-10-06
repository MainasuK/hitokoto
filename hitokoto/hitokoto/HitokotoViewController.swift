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
    
    private var hitokotoData: HitokotoData? // Use as strict scope as possible. You don't need to let everybody see the proberties.
    public var hitokotoID: Int?
    
    public func updateData() {
        if let unwrappedHD = hitokotoData {
            self.hitokotoLabel.text = "\(unwrappedHD.hitokoto)"
            self.authorLabel.text = "投稿人：\(unwrappedHD.author)"
            self.likeLabel.text = "Like：\(unwrappedHD.like)"
            self.dateLabel.text = "投稿日期：\(unwrappedHD.date)"
            self.catnameLabel.text = "\(unwrappedHD.catname)"
            self.idLabel.text = "ID：\(unwrappedHD.id)"
			self.sourceLabel.text = unwrappedHD.source == "" ? "未知出处" : "「\(unwrappedHD.source)」" // A smarter syntax to set the sourceLabel in 1 line which is also easier to read
            
            self.hitokotoID = unwrappedHD.id
        }
    }
    
    public func updateDataExtension() {
        if let unwrappedHD = hitokotoData {
            self.hitokotoLabel.text = "\(unwrappedHD.hitokoto)"
			self.sourceLabel.text = (unwrappedHD.source == "") ? "\"未知出处\"" : "——\(unwrappedHD.source)" // A smarter syntax to set the sourceLabel in 1 line which is also easier to read
        }
    }
    
    public func getHitokotoData(format: String, completion: (error: ErrorType?) -> ()) { // Use ErrorType rather than NSError which is much more powerful in Swift.
        HitokotoService.sharedInstance.fetchHitokotoData(format, completion: { (data, error) -> () in
            
            dispatch_async(dispatch_get_main_queue()) {
                guard let data = data where error == nil else {
                    completion(error: error)
                    return
                }
                
                self.hitokotoData = data
                completion(error: nil)
            }
        })
    }

}

