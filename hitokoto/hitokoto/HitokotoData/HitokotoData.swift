//
//  HitokotoData.swift
//  
//
//  Created by Cirno MainasuK on 2015-5-8.
//
//

import Foundation

// Create an error type that you'll use later
enum HitokotoDataInitializationError: ErrorType {
	case InvalidHitokotoData(identifier: String, data: AnyObject?)
}

struct HitokotoData { // You don't really need to use a class here since it's just a data structure. A struct would be much better on performance in Swift. Also as always, use as strict scope as possible.
    
    let hitokoto: String
	let source: String
    let category: String
    let author: String
    let like: Int
    let date: String
    let catname: String
    let id: Int
	
    init(hitokotoDictionary: NSDictionary) throws { // Create a throwable initializer rather than using forced unwrapping
        let jsonResult = hitokotoDictionary
        print(jsonResult)
		
		// Create constants that you'll use more than once
		let hitokotoIdentifier = "hitokoto"
		let sourceIdentifier = "source"
		let categoryIdentifier = "cat"
		let authorIdentifier = "author"
		let likeIdentifier = "like"
		let dateIdentifier = "date"
		let catnameIdentifier = "catname"
		let idIdentifier = "id"
		
		// Make sure every thing you need in the dictionary is valid
		guard let hitokoto = jsonResult[hitokotoIdentifier] as? String else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: hitokotoIdentifier, data: jsonResult[hitokotoIdentifier])
		}
		guard let source = jsonResult[sourceIdentifier] as? String else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: sourceIdentifier, data: jsonResult[sourceIdentifier])
		}
		guard let category = jsonResult[categoryIdentifier] as? String else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: categoryIdentifier, data: jsonResult[categoryIdentifier])
		}
		guard let author = jsonResult[authorIdentifier] as? String else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: authorIdentifier, data: jsonResult[authorIdentifier])
		}
		guard let like = jsonResult[likeIdentifier] as? Int else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: likeIdentifier, data: jsonResult[likeIdentifier])
		}
		guard let date = jsonResult[dateIdentifier] as? String else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: dateIdentifier, data: jsonResult[dateIdentifier])
		}
		guard let catname = jsonResult[catnameIdentifier] as? String else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: catnameIdentifier, data: jsonResult[catnameIdentifier])
		}
		guard let id = jsonResult[idIdentifier] as? Int else {
			throw HitokotoDataInitializationError.InvalidHitokotoData(identifier: idIdentifier, data: jsonResult[idIdentifier])
		}
		
		// Initialize
        self.hitokoto = hitokoto
        self.source = source
       
        self.category = category
        self.author = author
        self.like = like
        self.date = date
        self.catname = catname
        self.id = id
    }
}
