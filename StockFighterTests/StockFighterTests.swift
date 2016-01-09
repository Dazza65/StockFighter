//
//  StockFighterTests.swift
//  StockFighterTests
//
//  Created by Darren Harris on 09/01/2016.
//  Copyright © 2016 Darren Harris. All rights reserved.
//

import XCTest
@testable import StockFighter

class StockFighterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetStockPriceGreaterThanZero() {
        
        var expectation:XCTestExpectation?
        
        expectation = self.expectationWithDescription("Asynch getStockPrice call")
        
        let stockService = StockService()
        
        stockService.getStockPrice("TESTEX", symbol: "FOOBAR", completionHandler:{(price:Double) -> Void in
            print("value: \(price)")
            
            XCTAssert(price > 0, "The price should be greater than zero")
            
            expectation?.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testOrderbook() {
        
        var expectation:XCTestExpectation?
        
        expectation = self.expectationWithDescription("Asynch testOrderbook call")
        
        let stockService = StockService()
        
        stockService.getOrderbook("TESTEX", symbol: "FOOBAR", completionHandler:{(price:Double) -> Void in
            print("value: \(price)")
            
//            XCTAssert(price > 0, "The price should be greater than zero")
            
            expectation?.fulfill()
        })
        
        self.waitForExpectationsWithTimeout(10.0, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
