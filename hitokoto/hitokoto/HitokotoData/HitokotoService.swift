//
//  HitokotoService.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import Foundation

// Create an error type which you'll use later
enum HitokotoServiceError: ErrorType {
	case InvalidRetrievedDictionary
}

final class HitokotoService { // If you don't need to create another sub class inherited from this one, add a final prefix
    
    typealias HitokotoDataCompletionBlock = (data: HitokotoData?, error: ErrorType?) -> ()
    
    private let session: NSURLSession // Use as strict scope as possible. You don't need to let everybody see the proberties.
	
	static let sharedInstance = HitokotoService() // Since Swift 1.2 you don't need the ugly extra struct contanind in the class var anymore.
//    class var sharedInstance: HitokotoService {
//        struct Singleton {
//            static let instance = HitokotoService()
//        }
//        return Singleton.instance
//    }
	
    private init() { // Basically singleton design pattern is not so recommended but if you'd really like to use it, remember to hide the initializer.
        session = NSURLSession(configuration: .defaultSessionConfiguration())
    }
    
    func fetchHitokotoData(format: String, completion: HitokotoDataCompletionBlock) {
        
        let baseUrl = NSURL(string: "http://api.hitokoto.us/rand?\(format)")
        let request = NSURLRequest(URL: baseUrl!)
        print(baseUrl) // You don't need to do the forced formatting since the result is definitely the same.
		
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
			guard let data = data where error == nil  else { // If there's an error use guard rather than if which is easier to understand the logic. Also you may unwrap the optional value here so you don't need to forced unwrapping it later.
				completion(data: nil, error: error)
				return
			}
			
			do {
				guard let hitokotoDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary else { // Throw an error rather than using forced unwrapping
					throw HitokotoServiceError.InvalidRetrievedDictionary
				}
				let data = try HitokotoData(hitokotoDictionary: hitokotoDictionary)
				completion(data: data, error: nil)
				
			} catch let error {
				completion(data: nil, error: error)
			}
		}
		
		task.resume()
    }
    
    
}
