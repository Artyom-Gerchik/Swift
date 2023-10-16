//
//  UnitTests_FrameworkTests.swift
//  UnitTests_FrameworkTests
//
//  Created by Artyom on 13.10.23.
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

    func testCheckParams1(){
        let quadrangle = Quadrangle(sides: [-1, 1, 2, 3], angles: [90, 90, 90, 90]);
        XCTAssert(quadrangle.checkParams() == false, "1 TEST NOT PASSED")
    }
    
    func testCheckParams2(){
        let quadrangle = Quadrangle(sides: [1, 1, 2, 3], angles: [0, -90, 90, 90]);
        XCTAssert(quadrangle.checkParams() == false, "2 TEST NOT PASSED")
    }
    
    func testCheckAnglesSum(){
        let quadrangle = Quadrangle(sides: [1, 1, 2, 3], angles: [80, 90, 90, 90]);
        XCTAssert(quadrangle.checkAnglesSum() == false, "3 TEST NOT PASSED")
    }
    
    func testCheckEachAngles1(){
        let quadrangle = Quadrangle(sides: [1, 1, 2, 3], angles: [180, 1, 1, 1]);
        XCTAssert(quadrangle.checkEachAngle() == false, "4 TEST NOT PASSED")
    }
    
    func testCheckEachAngles2(){
        let quadrangle = Quadrangle(sides: [1, 1, 2, 3], angles: [1, 1, 180, 1]);
        XCTAssert(quadrangle.checkEachAngle() == false, "5 TEST NOT PASSED")
    }
    
    func testSidesSum1(){
        let quadrangle = Quadrangle(sides: [10, 1, 2, 3], angles: [90, 90, 90, 90]);
        XCTAssert(quadrangle.checkEachSide() == false, "6 TEST NOT PASSED")
    }
    
    func testSidesSum2(){
        let quadrangle = Quadrangle(sides: [1, 10, 2, 3], angles: [90, 90, 90, 90]);
        XCTAssert(quadrangle.checkEachSide() == false, "7 TEST NOT PASSED")
    }
    
    func testCheckSquare(){
        let quadrangle = Quadrangle(sides: [1, 1, 1, 1], angles: [90, 90, 90, 90]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Square, "8 TEST NOT PASSED")
    }
    
    func testCheckRectangle(){
        let quadrangle = Quadrangle(sides: [1, 2, 1, 2], angles: [90, 90, 90, 90]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Rectangle, "9 TEST NOT PASSED")
    }
    
    func testCheckRhombus(){
        let quadrangle = Quadrangle(sides: [1, 1, 1, 1], angles: [45, 135, 45, 135]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Rhombus, "10 TEST NOT PASSED")
    }
    
    func testCheckParallelogram(){
        let quadrangle = Quadrangle(sides: [1, 2, 1, 2], angles: [45, 135, 45, 135]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Parallelogram, "11 TEST NOT PASSED")
    }
    
    func testCheckTrapezoid1(){
        let quadrangle = Quadrangle(sides: [6, 4, 4, 8], angles: [45, 135, 120, 60]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Trapezoid, "12 TEST NOT PASSED")
    }
    
    func testCheckTrapezoid2(){
        let quadrangle = Quadrangle(sides: [4, 2, 4, 2], angles: [135, 120, 60, 45]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Trapezoid, "13 TEST NOT PASSED")
    }
    
    func testCheckDeltoid1(){
        let quadrangle = Quadrangle(sides: [2, 2, 4, 4], angles: [120, 80, 120, 40]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Deltoid, "14 TEST NOT PASSED")
    }
    
    func testCheckDeltoid2(){
        let quadrangle = Quadrangle(sides: [2, 4, 4, 2], angles: [40, 120, 80, 120]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Deltoid, "15 TEST NOT PASSED")
    }
    
    func testCheckQuadrangle(){
        let quadrangle = Quadrangle(sides: [3, 5, 6, 7], angles: [135, 50, 85, 90]);
        XCTAssert(quadrangle.checkType() == Quadrangle.QuadrangleType.Quadrangle, "16 TEST NOT PASSED")
    }

}
