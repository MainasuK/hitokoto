//
//  HitokotoService.swift
//  hitokoto
//
//  Created by Cirno MainasuK on 2015-5-8.
//  Copyright (c) 2015年 Cirno MainasuK. All rights reserved.
//

import Foundation

// Create an error type which you'll use later
public enum HitokotoServiceError: ErrorType {
	case InvalidRetrievedDictionary
	case InvalidURLFormat(format: String)
    case NSURLError(format: String)
}

final class HitokotoService { // If you don't need to create another sub class inherited from this one, add a final prefix
    
    typealias HitokotoDataCompletionBlock = (data: HitokotoData?, error: ErrorType?) -> ()
    
    private let kTimeout = NSTimeInterval(5.0)
    private let session: NSURLSession // Use as strict scope as possible. You don't need to let everybody see the proberties.
	
	static let sharedInstance = HitokotoService() // Since Swift 1.2 you don't need the ugly extra struct contanind in the class var anymore.
	
    private init() { // Basically singleton design pattern is not so recommended but if you'd really like to use it, remember to hide the initializer.
        session = NSURLSession(configuration: .defaultSessionConfiguration())

    }
    
    func fetchHitokotoData(format: String, completion: HitokotoDataCompletionBlock) {

		guard let baseUrl = NSURL(string: "http://api.hitokoto.us/rand?\(format)") else { // Throw an error rather than using forced unwrapping
			completion(data: nil, error: HitokotoServiceError.InvalidURLFormat(format: format))
			return
		}
        
        print("Fetching data from: \(baseUrl)…")
        let request = NSURLRequest(URL: baseUrl, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: kTimeout)
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
			guard let data = data where error == nil  else {
                print(error!.localizedDescription)
				completion(data: nil, error: HitokotoServiceError.NSURLError(format: error!.localizedDescription))
				return
			}
			
			do {
				guard let hitokotoDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? [String: NSObject] else {
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
