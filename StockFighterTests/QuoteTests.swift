//
//  QuoteTests.swift
//  StockFighter
//
//  Created by Darren Harris on 09/01/2016.
//  Copyright © 2016 Darren Harris. All rights reserved.
//

import XCTest
@testable import StockFighter

class QuoteTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQuote() {
        let quote = Quote(symbol: "VODL", bid: nil)
        
        XCTAssert(quote.symbol == "VODL", "Symbol not as expected")
        XCTAssert(quote.bid == nil, "bidPrice is expected to be nil")
        
    }
    
    func testQuoteFromJSON() {
        let quoteDictionary = ["symbol":"VODL", "bidPrice":102.14]
        
        print("quoteDictionary: \(quoteDictionary)")
        
        let quote = Quote(quoteDictionary: quoteDictionary)
        
        XCTAssert(quote.symbol == "VODL", "Symbol not as expected")
        XCTAssert(quote.bid == 102.14, "Quote.bid not as expected")

    }
    

}
