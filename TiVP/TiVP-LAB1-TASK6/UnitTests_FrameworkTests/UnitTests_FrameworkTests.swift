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

    func testFirstTask() {
        
        let url =  "https://www.africau.edu/images/default/sample.pdf" //
        var destinationUrl =  "/Users/lnxd/Desktop/folder_for_task6" //

        destinationUrl = "file://" + destinationUrl;
        
        XCTAssert(loadFileSync(url: URL(string: url)!, destinationUrl1: URL(string: destinationUrl)!) == "FILE SAVED", "Test 1 NOT Passed")
        XCTAssert(loadFileSync(url: URL(string: url)!, destinationUrl1: URL(string: destinationUrl)!) == "FILE EXISTS", "Test 1 NOT Passed")
    }

}
