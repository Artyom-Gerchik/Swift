//
//  UnitTests_FrameworkTests.swift
//  UnitTests_FrameworkTests
//
//  Created by Artyom on 29.09.23.
//

import XCTest
@testable import UnitTests_Framework

final class UnitTests_FrameworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testThirdTask() {
        XCTAssert(testMain(a:0, b:0) == "FOLLOW THE PATTERN", "TEST 1 FAILED")
        XCTAssert(testMain(a:1, b:1) == "1", "TEST 2 FAILED")
        XCTAssert(testMain(a:1, b:0) == "FOLLOW THE PATTERN", "TEST 3 FAILED")
    }

}
