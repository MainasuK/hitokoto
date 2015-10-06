//
//  MainViewController.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import UIKit
import HitokotoDataKit

final class MainViewController: HitokotoViewController { // If you don't need to create another sub class inherited from this one, add a final prefix
	
    private let format = "charset=utf-8" // Basically use let if possible, and use as strict scope as possible
    
    @IBAction func refreshData(sender: UIButton) { //While adding an @IBAction you may specify the sender as a UIButton rather than AnyObject so that you don't need to do the additional cast down
        sender.enabled = false
        getHitokotoData(format, completion: { (error) -> () in
			// You may use defer to set the actions you'd like to perform at the end of the scope
			defer {
				sender.enabled = true
			}
			
			// If there's an error use guard rather than if which is easier to understand the logic.
			guard error == nil else {
				debugPrint(error) // Display the error in console window so it's easier to debug
				return
			}
			
			self.updateData()
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
			// If there's an error use guard rather than if which is easier to understand the logic.
			guard error == nil else {
				debugPrint(error) // Display the error in console window so it's easier to debug
				return
			}
			self.updateData()
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
