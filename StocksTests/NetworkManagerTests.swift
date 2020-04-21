//
//  NetworkManagerTests.swift
//  StocksTests
//
//  Created by oren shalev on 19/04/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import XCTest
@testable import Stocks

class NetworkManagerTests: XCTestCase {

    var controllerViewModel : ControllerViewModel!

    override func setUp() {
        controllerViewModel = ControllerViewModel()

    }

    override func tearDown() {
        controllerViewModel = nil
    }


    func testGetCandlesFor1min() {
        
        
        let stock = controllerViewModel.stocks[0]
        
        let semaphore = DispatchSemaphore(value: 0)

        NetworkManager.getCandlesFor(stock: stock, and: "1min") { (candles, observationCandles) in
            
                
                semaphore.signal()

            
        }
        
        let timeout = DispatchTime.now() + .seconds(10)

        if semaphore.wait(timeout: timeout) == .timedOut {
            
            XCTFail("candles request timed out")
            
        }
    }

    
    func testGetCandlesFor5min() {
        
        
        let stock = controllerViewModel.stocks[0]
        
        let semaphore = DispatchSemaphore(value: 0)

        NetworkManager.getCandlesFor(stock: stock, and: "5min") { (candles, observationCandles) in
            
                
                semaphore.signal()

            
        }
        
        let timeout = DispatchTime.now() + .seconds(10)

        if semaphore.wait(timeout: timeout) == .timedOut {
            
            XCTFail("candles request timed out")
            
        }
    }
    
}
