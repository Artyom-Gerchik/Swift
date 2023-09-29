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

    func testFifthTask() {
        
        XCTAssert(task5(path: "/Users/lnxd/Desktop/MZI", ext: "pdf")[0] == URL(string: "file:///Users/lnxd/Desktop/MZI/LAB1.pdf"), "Test 1 NOT Passed")
        XCTAssert(task5(path: "/Users/lnxd/Desktop/MZI", ext: "pdf")[1] != URL(string: "file:///Users/lnxd/Desktop/MZI/LAB1.pdf"), "Test 2 NOT Passed")
        XCTAssert(task5(path: "/Users/lnxd/Desktop/MZI", ext: "pdf")[1] == URL(string: "file:///Users/lnxd/Desktop/MZI/LAB1/LAB1.pdf"), "Test 3 NOT Passed")
    }

}
