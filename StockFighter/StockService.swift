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
                    
                    let quote = Quote(quoteDictionary: stockDictionary!)
                    print("quote.symbol: \(quote.symbol)")
                    print("quote.bid: \(quote.bid)")
                    
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
    
    func getOrderbook(venue: String, symbol: String, completionHandler: (orderBook:NSDictionary?) -> Void) {
        
        var orderBookDictionary: NSDictionary?
        
        let url = NSURL(string: "https://api.stockfighter.io/ob/api/venues/\(venue)/stocks/\(symbol)")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "X-Starfighter-Authorization")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print("Error \(error)")
                completionHandler(orderBook: nil)
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        orderBookDictionary = self.parseJSON(responseData)
                        completionHandler(orderBook: orderBookDictionary)
                    }
                }
                else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                completionHandler(orderBook: nil)
                }
            }
        })
        task.resume()
    }

    func placeOrder(order: Order, completionHandler: (orderRespone:NSDictionary?) -> Void) {
        var orderDictionary: NSDictionary?
        
        let url = NSURL(string: "https://api.stockfighter.io/ob/api/venues/\(order.venue)/stocks/\(order.stock)/orders")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: "X-Starfighter-Authorization")
        request.HTTPBody =  (order.JSONStringify()).dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print("Error \(error)")
                completionHandler(orderRespone: nil)
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    if let responseData = data {
                        orderDictionary = self.parseJSON(responseData)
                        print("OrderDictionary \(orderDictionary)")
                        completionHandler(orderRespone: orderDictionary)
                    }
                }
                else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    completionHandler(orderRespone: nil)
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

