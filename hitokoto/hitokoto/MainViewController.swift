//
//  MainViewController.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import UIKit
import HitokotoDataKit

class MainViewController: HitokotoViewController {

    var format = "charset=utf-8"
    
    @IBAction func refreshData(sender: AnyObject) {
        let refreshButton = sender as? UIButton
        refreshButton?.enabled = false
        getHitokotoData(format, completion: { (error) -> () in
            if error == nil {
                self.updateData()
            }
            
            refreshButton?.enabled = true
        })
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
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        getHitokotoData(format, completion: { (error) -> () in
            if error == nil {
                self.updateData()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
