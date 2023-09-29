//
//  UnitTests_FrameworkTests.swift
//  UnitTests_FrameworkTests
//
//  Created by Artyom on 28.09.23.
//

import XCTest
@testable import UnitTests_Framework
//@testable import TiVP_LAB1_TASK1

final class UnitTests_FrameworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFirstTask() {
        var dict = [Int:Int]()
        XCTAssert(task1ForTest()[0] == "Hello, World!", "Test for Hello World NOT Passed")
        XCTAssert(task1ForTest()[1] == "Andhiagain!", "Test for Andhiagain NOT Passed")
        for _ in 0...10000{
            let val = task1ForTest()[2].count
            if(dict[val] == nil){
                dict.updateValue(1, forKey: val)
            }else{
                dict.updateValue(dict[val]! + 1, forKey: val)
            }
            XCTAssert(5...50 ~= val, "Random Test NOT Passed")
        }
        XCTAssert(dict.count == 46, "Random Test NOT Passed")
        print(Array(dict.keys).sorted(by: <))
    }
}
