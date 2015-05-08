//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Playground - noun: a place where people can play

let getURL = "http://api.hitokoto.us/rand?charset=utf-8"


let TimeOut = 50

println(getURL)

var request = NSMutableURLRequest()
let urlPath: String = getURL
var url: NSURL = NSURL(string: urlPath)!

request = NSMutableURLRequest(URL: url)
request.HTTPMethod = "GET"

var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
var error: NSErrorPointer = nil
var dataVal = NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
var err: NSError

println(response)


var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
println("Synchronous\(jsonResult)")

let hitokoto = jsonResult["hitokoto"] as? String
let category = jsonResult["cat"] as? String
let author = jsonResult["author"] as? String
let like = jsonResult["like"] as? Int
let data = jsonResult["date"] as? String
let catname = jsonResult["catname"] as? String
let id = jsonResult["id"] as? Int

