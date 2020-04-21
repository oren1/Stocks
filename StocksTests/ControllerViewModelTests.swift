//
//  ControllerViewModelTests.swift
//  StocksTests
//
//  Created by oren shalev on 19/04/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import XCTest
@testable import Stocks

class ControllerViewModelTests: XCTestCase {

    var controllerViewModel : ControllerViewModel!
    
    override func setUp() {
        super.setUp()
        controllerViewModel = ControllerViewModel()
    }

    override func tearDown() {

        controllerViewModel = nil
        super.tearDown()

    }

    func testStocksArray() {
        
        XCTAssertTrue(controllerViewModel.stocks.count > 0, "Couldn't parse the array")
        
    }

    
    
    
}
