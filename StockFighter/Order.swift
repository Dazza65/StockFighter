//
//  Order.swift
//  StockFighter
//
//  Created by Darren Harris on 10/01/2016.
//  Copyright © 2016 Darren Harris. All rights reserved.
//

import Foundation

class Order {
    let account: String
    let venue: String
    let stock: String
    let price: Int
    let qty: Int
    let direction: String
    let orderType: String
    
    init(account: String, venue: String, stock: String, price: Int, qty: Int, direction: String, orderType: String) {
        self.account = account
        self.venue = venue
        self.stock = stock
        self.price = price
        self.qty = qty
        self.direction = direction
        self.orderType = orderType
    }
    
    func JSONStringify() -> String {
        
        let jsonObject: AnyObject = ["account": self.account,
                                        "venue": self.venue,
                                        "stock": self.stock,
                                        "price": self.price,
                                        "qty": self.qty,
                                        "direction": self.direction,
                                        "orderType": self.orderType]
        
        if NSJSONSerialization.isValidJSONObject(jsonObject) {
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions.PrettyPrinted)
                
                if let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return jsonString as String
                }
            } catch {
                print("error creating JSON for Order")
            }
        }
        
        return ""
    }
}