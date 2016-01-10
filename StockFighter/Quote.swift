//
//  Quote.swift
//  StockFighter
//
//  Created by Darren Harris on 09/01/2016.
//  Copyright © 2016 Darren Harris. All rights reserved.
//

import Foundation

class Quote {
    let symbol: String
    let bid: Double?
    
    init(symbol: String, bid: Double?) {
        self.symbol = symbol
        self.bid = bid
    }
    
    init(quoteDictionary: NSDictionary) {
        self.symbol = quoteDictionary.valueForKey("symbol") as! String
        if let bidPrice = quoteDictionary.valueForKey("bid") as? Double {
            self.bid = bidPrice / 100
        }
        else {
            self.bid = nil
        }
    }
}