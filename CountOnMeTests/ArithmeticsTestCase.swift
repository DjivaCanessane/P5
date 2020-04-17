//
//  ArithmeticsTestCase.swift
//  CountOnMeTests
//
//  Created by Djiva Canessane on 17/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class ArithmeticsTestCase: XCTestCase {
    // MARK: - Properties
    var arithmetics: Arithmetics = Arithmetics()

    // MARK: - Tests

    // Test calculation with each type of operator
    func testGivenCalculation_WhenSubstraction_ThenShowResult() {
        addCalculation("3 - 2")
        XCTAssertEqual(arithmetics.calculate(), "1")
    }

    func testGivenCalculation_WhenAddition_ThenShowResult() {
        addCalculation("3 + 2")
        XCTAssertEqual(arithmetics.calculate(), "5")
    }

    func testGivenCalculation_WhenMultiplication_ThenShowResult() {
        addCalculation("3 × 2")
        XCTAssertEqual(arithmetics.calculate(), "6")
    }

    func testGivenCalculation_WhenDivision_ThenShowResult() {
        addCalculation("4 ÷ 2")
        XCTAssertEqual(arithmetics.calculate(), "2")
    }

    func testGivenCalculation_WhenDivisionByZero_ThenShowError() {
        addCalculation("4 ÷ 0")
        XCTAssertEqual(arithmetics.calculate(), "impossible")
    }

    // Test expressionIsCorrect after each type of operator
    func testGivenCalculationEndWithPlusOperator_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 +")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    func testGivenCalculationEndWithMinusOperator_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 -")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    func testGivenCalculationEndWithMultiplicationOperator_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 ×")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    func testGivenCalculationEndWithDivisionOperator_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 ÷")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    // Test expressionHasEnoughElement
    func testGivenCalculationWithTwoElements_WhenExpressionHasEnoughElement_ThenReturnFalse() {
        addCalculation("45")
        XCTAssertFalse(arithmetics.expressionHasEnoughElement)
    }

    func testGivenCalculationWithThreeElements_WhenExpressionHasEnoughElement_ThenReturnTrue() {
        addCalculation("45 + 6")
        XCTAssertTrue(arithmetics.expressionHasEnoughElement)
    }

    // Test canAddOperator after each type of operator
    func testGivenCalculationEndWithPlusOperator_WhenCanAddOperator_ThenReturnFalse() {
        addCalculation("3 +")
        XCTAssertFalse(arithmetics.canAddOperator)
    }

    func testGivenCalculationEndWithMinusOperator_WhenCanAddOperator_ThenReturnFalse() {
        addCalculation("3 -")
        XCTAssertFalse(arithmetics.canAddOperator)
    }

    func testGivenCalculationEndWithMultiplicationOperator_WhenCanAddOperator_ThenReturnFalse() {
        addCalculation("3 ×")
        XCTAssertFalse(arithmetics.canAddOperator)
    }

    func testGivenCalculationEndWithDivisionOperator_WhenCanAddOperator_ThenReturnFalse() {
        addCalculation("3 ÷")
        XCTAssertFalse(arithmetics.canAddOperator)
    }

    // Test expressionHasResult
    func testGivenEmptyCalculation_WhenCheckExpressionHasResult_ThenReturnFalse() {
        addCalculation("3 + 5")
        XCTAssertFalse(arithmetics.expressionHasResult)
    }

    func testGivenCalculation_WhenCalculate_ThenExpressionHasResultReturnTrue() {
        addCalculation("3 + 5")
        let result: String = arithmetics.calculate()
        XCTAssertEqual(result, "8")
        XCTAssertTrue(arithmetics.expressionHasResult)
    }

    func testGivenCalculationAndCalculate_WhenResetCalculation_ThenExpressionHasResultReturnFalse() {
        addCalculation("3 - 5")
        let result: String = arithmetics.calculate()
        arithmetics.resetCalculation()
        XCTAssertEqual(result, "-2")
        XCTAssertFalse(arithmetics.expressionHasResult)
    }

    // MARK: - Methods
    override func setUp() {
        super.setUp()
        arithmetics.resetCalculation()
    }

    func addCalculation(_ calculation: String) {
        arithmetics.calculation.append(calculation)
    }
}
