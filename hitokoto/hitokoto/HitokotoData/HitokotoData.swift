//
//  HitokotoData.swift
//  
//
//  Created by Cirno MainasuK on 2015-5-8.
//
//

import Foundation

public class HitokotoData: NSObject {
    
    let hitokoto: String
    let category: String
    let author: String
    let like: Int
    let date: String
    let catname: String
    let id: Int
    let source: String
    
    public init(hitokotoDictionary: NSDictionary) {
        let jsonResult = hitokotoDictionary
        println(jsonResult)
        
        hitokoto = jsonResult["hitokoto"] as! String
        source = jsonResult["source"] as! String
       
        category = jsonResult["cat"] as! String
        author = jsonResult["author"] as! String
        like = jsonResult["like"] as! Int
        date = jsonResult["date"] as! String
        catname = jsonResult["catname"] as! String
        id = jsonResult["id"] as! Int
    }
}
