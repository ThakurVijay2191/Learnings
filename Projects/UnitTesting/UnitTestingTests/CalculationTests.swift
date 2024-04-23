//
//  CalculationTests.swift
//  UnitTestingTests
//
//  Created by Nap Works on 18/04/24.
//

import XCTest
@testable import UnitTesting

final class CalculationTests: XCTestCase {

    func testSuccessfullTipCalculation(){
        ///given (Arrange)
        let enteredAmount = 100.00
        let tipSlider = 25.0
        
        ///when (Act)
        let tip = Calculation().calculateTip(of: enteredAmount, with: tipSlider)
        
        ///then (Assert)
        XCTAssertEqual(tip, 25)
    }
    
    func testNegativeEnteredAmountTipCalculation(){
        ///given (Arrange)
        let enteredAmount = -100.00
        let tipSlider = 25.0
        
        ///when (Act)
        let tip = Calculation().calculateTip(of: enteredAmount, with: tipSlider)
        
        ///then (Assert)
        XCTAssertNil(tip)
    }
}
