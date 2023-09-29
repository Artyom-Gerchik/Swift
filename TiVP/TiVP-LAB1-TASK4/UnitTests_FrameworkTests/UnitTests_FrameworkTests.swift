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
    
    func testFourthTask() {
        var arr = task4()
        XCTAssert(arr[0] == "<!DOCTYPE html> <html lang='en'> <head> <title>A simple HTML document</title> </head> <body> <table cellspacing='0' style='width: 100%; height: 100vh' >", "Test 1 NOT Passed")
        XCTAssert(arr[1] == "<tr><th style='background: rgb(\(255 - 0), \(255 - 0), \(255 - 0));'></th></tr>", "Test 2 NOT Passed")
        XCTAssert(arr[257] == "</table> </body> </html>", "Test 3 NOT Passed")
    }
}
