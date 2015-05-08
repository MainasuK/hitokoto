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
        println("\(baseUrl)")
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            if error == nil {
                var jsonError: NSError?
                if jsonError == nil {
                    let hitokotoDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as! NSDictionary
                    
                    let data = HitokotoData(hitokotoDictionary: hitokotoDictionary)
                    completion(data: data, error: nil)
                } else {
                    completion(data: nil, error: jsonError)
                }
            } else {
                completion(data: nil, error: error)
            }
        }
        
        task.resume()
    }
    
    
}
