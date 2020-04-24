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

    // Test calculation with each type of operand
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

    func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizingMultiplication() {
        addCalculation("1 + 2 × 3 + 4 × 2")
        XCTAssertEqual(arithmetics.calculate(), "15")
    }

    func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizeDivision() {
        addCalculation("1 + 4 ÷ 2 + 4 ÷ 2")
        XCTAssertEqual(arithmetics.calculate(), "5")
    }

    // Test expressionIsCorrect after each type of operand
    func testGivenCalculationEndWithPlusOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 +")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    func testGivenCalculationEndWithMinusOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 -")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    func testGivenCalculationEndWithMultiplicationOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 ×")
        XCTAssertFalse(arithmetics.expressionIsCorrect)
    }

    func testGivenCalculationEndWithDivisionOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
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

    // Test canAddOperand after each type of operand
    func testGivenCalculationEndWithPlusOperand_WhenCanAddOperand_ThenReturnFalse() {
        addCalculation("3 +")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    func testGivenCalculationEndWithMinusOperand_WhenCanAddOperand_ThenReturnFalse() {
        addCalculation("3 -")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    func testGivenCalculationEndWithMultiplicationOperand_WhenCanAddOperand_ThenReturnFalse() {
        addCalculation("3 ×")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    func testGivenCalculationEndWithDivisionOperand_WhenCanAddOperand_ThenReturnFalse() {
        addCalculation("3 ÷")
        XCTAssertFalse(arithmetics.canAddOperand)
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

    // Test delete method
    func testGivenCalculationEndingWithInt_WhenDeleteElement_ThenCalculationWithoutLastElement() {
        addCalculation("3 + 5")
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "3 + ")
    }

    func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationWithoutLastElement() {
        addCalculation("3 + ")
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "3")
    }

    func testtestGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationIsEmpty() {
        addCalculation("45 × 56")
        arithmetics.resetCalculation()
        XCTAssertEqual(arithmetics.calculation, "")
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
