//
//  PlanItTests.swift
//  PlanItTests
//
//  Created by Helen Wang on 5/29/20.
//  Copyright © 2020 Helen Wang. All rights reserved.
//

import XCTest
@testable import PlanIt

class PlanItTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let month1 = Month(month: 6, year: 2020)
        let month2 = Month()
        
        XCTAssertEqual(month1.equals(month: month2), true)
        XCTAssertEqual(month1.currMonth == month2.currMonth, true)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
