//
//  HitokotoService.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import Foundation

class HitokotoService {
    
    typealias HitokotoDataCompletionBlock = (data: HitokotoData?, error: NSError?) -> ()
    
    let session: NSURLSession
    
    class var sharedInstance: HitokotoService {
        struct Singleton {
            static let instance = HitokotoService()
        }
        return Singleton.instance
    }
    
    init() {
        session = NSURLSession(configuration: .defaultSessionConfiguration())
    }
    
    func fetchHitokotoData(format: String, completion: HitokotoDataCompletionBlock) {
        
        let baseUrl = NSURL(string: "http://api.hitokoto.us/rand?\(format)")
        let request = NSURLRequest(URL: baseUrl!)
        print("\(baseUrl)")
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            if error == nil {
                do {
                    let hitokotoDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let data = HitokotoData(hitokotoDictionary: hitokotoDictionary)
                    completion(data: data, error: nil)
                } catch let error as NSError {
                    completion(data: nil, error: error)
                }
            } else {
                completion(data: nil, error: error)
            }
        }
        
        task.resume()
    }
    
    
}
