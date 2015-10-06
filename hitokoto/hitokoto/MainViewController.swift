//
//  MainViewController.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import UIKit
import Social
import HitokotoDataKit

final class MainViewController: HitokotoViewController { // If you don't need to create another sub class inherited from this one, add a final prefix
	
    private var isFirstLoad = true
    private let format = "charset=utf-8" // Basically use let if possible, and use as strict scope as possibl
    private let viewUrl = "hitokoto.us/view/"
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBAction func refreshData(sender: UIButton) { //While adding an @IBAction you may specify the sender as a UIButton rather than AnyObject so that you don't need to do the additional cast down
        sender.hidden = true
        shareButton.enabled = false

        let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        spinner.center = sender.center
        spinner.color = sender.titleColorForState(.Normal)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.view.addSubview(spinner)
        self.view.userInteractionEnabled = false
        
        getHitokotoData(format, completion: { (error) -> () in
            // You may use defer to set the actions you'd like to perform at the end of the scope
			defer {
                spinner.stopAnimating()
				sender.hidden = false
                self.view.userInteractionEnabled = true
			}
			
			guard error == nil else {
                // FIXME: async error handle 
//                do {
//                    try self.throwError(error!)
//                } catch HitokotoServiceError.NSURLError(let format) {
//                    
//                }
                self.showAlertMessage("数据获取失败，请刷新重试")
				return
			}
			
			self.updateData()
            self.shareButton.enabled = true
        })
    }
    
    @IBAction func shareButtonPressed(sender: UIBarButtonItem) {
        
        guard let hitokoto = self.hitokotoLabel.text,
        let source = self.sourceLabel.text,
        let id = self.hitokotoID,
        let url = NSURL(string: ("http://" + "\(self.viewUrl)" + "\(id)") ) else {
            self.showAlertMessage("没有一言可以用来分享哟")
            return
        }
        
        let objectToShare = ["「\(hitokoto)」\(source) | 一言", url]
        let activityViewController = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        hitokotoLabel.text = "少女祈祷中"
        authorLabel.text = ""
        likeLabel.text = ""
        dateLabel.text = ""
        catnameLabel.text = ""
        idLabel.text = ""
        sourceLabel.text = "Loading..."
        
        idLabel.hidden = true
        
        NSLog(refreshButton.tintColor.description)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isFirstLoad {
            return
        }
        
        isFirstLoad = false
        refreshData(refreshButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertMessage(message: String!) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
//    func throwError(error: ErrorType) throws {
//        throw error
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
