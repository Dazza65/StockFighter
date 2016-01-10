//
//  OrderTests.swift
//  StockFighter
//
//  Created by Darren Harris on 10/01/2016.
//  Copyright © 2016 Darren Harris. All rights reserved.
//

import XCTest

class OrderTests: XCTestCase {
    
    let tradingAccount: String = "FFB4784531"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSON() {
        let order = Order(account: tradingAccount, venue: "LSE", stock: "VOD.L", price: 1000, qty: 200, direction: "buy", orderType: "limit")
        
        print("Order: \(order.JSONStringify())")
        
    }
    
    func testPlaceOrder() {
        let order = Order(account: tradingAccount, venue: "KLOMEX", stock: "TOLM", price: 4000, qty: 1000, direction: "buy", orderType: "limit")
        
        var expectation:XCTestExpectation?
        
        expectation = self.expectationWithDescription("Place order")
        
        let stockService = StockService()

            stockService.placeOrder(order, completionHandler: {(orderResponse: NSDictionary?) -> Void in
                print("value: got order response")
                
                XCTAssert(orderResponse?.valueForKey("id") as! Int > 0, "Order number not valid")
                
                expectation?.fulfill()
            })
            
            self.waitForExpectationsWithTimeout(10.0, handler: nil)
            
    }
    
    func testPlaceBlockOrder() {
        let order = Order(account: tradingAccount, venue: "KLOMEX", stock: "TOLM", price: 4000, qty: 1000, direction: "buy", orderType: "limit")
        
        var expectation:XCTestExpectation?
        
        let stockService = StockService()
        
        for i in 0..<100 {
            expectation = self.expectationWithDescription("Place order")
            
            stockService.placeOrder(order, completionHandler: {(orderResponse: NSDictionary?) -> Void in
                print("value: got order response")
                
                XCTAssert(orderResponse?.valueForKey("id") as! Int > 0, "Order number not valid")
                
                expectation?.fulfill()
            })
            
            self.waitForExpectationsWithTimeout(10.0, handler: nil)
            
            sleep(10)
        }

    }
    
    func testGetOrderStatus() {
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
