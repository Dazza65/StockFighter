//
//  StockService.swift
//  StockFighter
//
//  Created by Darren Harris on 09/01/2016.
//  Copyright © 2016 Darren Harris. All rights reserved.
//

import Foundation

class StockService {
    
    let apiKey = "8ec9bb6eab46bff46c1f7519372dbac8413c1d35"
    
    func getStockPrice(venue: String, symbol: String, completionHandler: (price:Double) -> Void) {
        
        var stockDictionary: NSDictionary?
        
        let url = NSURL(string: "https://api.stockfighter.io/ob/api/venues/\(venue)/stocks/\(symbol)/quote")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-Starfighter-Authorization")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print("Error \(error)")
                completionHandler(price: -1)
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        stockDictionary = self.parseJSON(responseData)
                        print("StockDictionary \(stockDictionary)")
                    }
                    
                    if let bidPrice = stockDictionary?.valueForKey("bid") as? Double {
                        completionHandler(price: bidPrice / 100)
                    }
                    else {
                        completionHandler(price: -1)
                    }
                }
                else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    completionHandler(price: -1)
                }
            }
        })
        task.resume()
    }
    
    func getOrderbook(venue: String, symbol: String, completionHandler: (price:Double) -> Void) {
        
        var stockDictionary: NSDictionary?
        
        let url = NSURL(string: "https://api.stockfighter.io/ob/api/venues/\(venue)/stocks/\(symbol)")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-Starfighter-Authorization")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print("Error \(error)")
                completionHandler(price: -1)
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        stockDictionary = self.parseJSON(responseData)
                        print("StockDictionary \(stockDictionary)")
                    }
                    
                    if let bidPrice = stockDictionary?.valueForKey("bid") as? Double {
                        completionHandler(price: bidPrice / 100)
                    }
                    else {
                        completionHandler(price: -1)
                    }
                }
                else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    completionHandler(price: -1)
                }
            }
        })
        task.resume()
    }

    
    func parseJSON(inputData: NSData) -> NSDictionary {
        var error: NSError?
        let anyObj: AnyObject?
        
        do {
            anyObj = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers)
        } catch let error1 as NSError {
            error = error1
            anyObj = nil
        }
        
        if error != nil {
            print("")
            return NSDictionary()
        } else {
            return anyObj as! NSDictionary
        }
    }
}

