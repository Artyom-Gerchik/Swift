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
    
    func testSecondTask() {
        let brain = Brain()
        let human1 = Human(Name: "Artyom", Surname: "Gerchik", Age: 20)
        let human2 = Human(Name: "Anna", Surname: "Dolganova", Age: 19)

        XCTAssert(brain.getHumans(humans: [human1, human2]), "Test For getHumans NOT Passed")
        XCTAssert(brain.printHumans()[0] == "Gerchik Artyom 20" && brain.printHumans()[1] == "Dolganova Anna 19", "Test For printHumans NOT Passed")
        XCTAssert(brain.getLowestHighestAndMediumAge()[0] == 20 && brain.getLowestHighestAndMediumAge()[1] == 19 && brain.getLowestHighestAndMediumAge()[2] == 19.5 ,"Test For getHumans NOT Passed")
    }

}
