//
//  JSONRatesAPI.swift
//  iOS Dev Assignment
//
//  Created by Arthur Myronenko on 19.05.15.
//  Copyright (c) 2015 Arthur Myronenko. All rights reserved.
//

import Foundation

class JSONRatesAPI {
    private static let key = "6f5abeb086ac142f3376b3b74c0bd304"
    private static let url = "http://apilayer.net/api/"
    
    class func convert(fromCurrency: String, toCurrency: String, completionHandler: (Double) -> ()) {
        let requestURL = NSURL(string: url + "convert?" + "from=" + fromCurrency + "&to=" + toCurrency + "&amount=1&access_key=" + key)
        let request = NSURLRequest(URL: requestURL!)
        
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
            if (error != nil) {
                print(error)
                return
            }
            let json = JSON(data: data!)
            if let rate = json["rate"].double {
                completionHandler(rate)
            } else {
                print("Error in parsing JSON: " + json.description)
            }
        }
    }
    
    class func requestAllRates(base: String, completionHander: ([String: Double]) -> ()) {
        let requestURL = NSURL(string: url + "live?access_key=" + key)
        let request = NSURLRequest(URL: requestURL!)
        
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
            if (error != nil) {
                print(error)
                return
            }
            let json = JSON(data: data!)
            if let rates = json["quotes"].dictionary {
                var ratesDictionary = [String: Double]()
                for rate in rates {
                    if let price = rate.1.double {
                        ratesDictionary.updateValue(price, forKey: rate.0.stringByReplacingOccurrencesOfString("USD", withString: ""))
                    }
                }
                completionHander(ratesDictionary)
            } else {
                print("Error in parsing JSON: " + json.description)
            }
        }
    }
    
    class func requestCurrenciesList(completionHandler: ([String: String]) -> ()) {
        let requestURL = NSURL(string: "http://jsonrates.com/currencies.json")
        let request = NSURLRequest(URL: requestURL!)
        
        let queue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: queue) { (response, data, error) -> Void in
            if (error != nil) {
                print(error)
                return
            }
            let json = JSON(data: data!)
            if let currList = json.dictionary {
                var currDictionary = [String: String]()
                for curr in currList {
                    if let currName = curr.1.string {
                        currDictionary.updateValue(currName, forKey: curr.0)
                    }
                }
                completionHandler(currDictionary)
            } else {
                print("Error in parsing JSON: " + json.description)
            }
        }
    }
    
    
}








