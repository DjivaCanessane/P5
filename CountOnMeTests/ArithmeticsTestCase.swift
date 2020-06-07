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
    // MARK: - Property
    var arithmetics: Arithmetics = Arithmetics()

    // MARK: - Test calculation with each type of operand

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

    func testGivenCalculation_WhenUsingAnotherOperand_ThenShowError() {
        arithmetics.calculation = "4 / 5"
        let result = arithmetics.calculate()
        XCTAssertEqual(result, "Unknown operand !")
    }
    // MARK: - Test Errors
    func testGivenCalculation_WhenDivisionByZero_ThenShowError() {
        addCalculation("4 ÷ 0")
        XCTAssertEqual(arithmetics.calculate(), "impossible")
    }

    func testGivenZero_WhenAddingAnotherOperand_ThenZero() {
        addCalculation("/")
        XCTAssertEqual(arithmetics.calculation, "0")
    }

    func testGivenNonNumeralElementToRight_WhenCalculate_ThenError() {
        arithmetics.calculation = "A + 4"
        XCTAssertEqual(arithmetics.calculate(), "error")
    }

    func testGivenNonNumeralElementToLeft_WhenCalculate_ThenError() {
        arithmetics.calculation = "4 + B"
        XCTAssertEqual(arithmetics.calculate(), "error")
    }

    // MARK: - Test prioritizing operations
    func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizingMultiplication() {
        addCalculation("1 + 2 × 3 + 4 × 2")
        let result: String = arithmetics.calculate()
        XCTAssertEqual(result, "15")
    }

    func testGivenCalculationWithMultipleOperand_WhenCalculate_ThenCalculateWithPrioritizeDivision() {
        addCalculation("1 + 4 ÷ 2 + 4 ÷ 2")
        XCTAssertEqual(arithmetics.calculate(), "5")
    }

    // MARK: - Test calculation when starting with - or +
    func testGivenCalculation_WhenStartingWithPlus_ThenShowError() {
        addCalculation(" - 4 + 3")
        XCTAssertEqual(arithmetics.calculate(), "-1")
    }

    func testGivenCalculation_WhenStartingWithMinus_ThenShowError() {
        addCalculation(" + 4 + 3")
        XCTAssertEqual(arithmetics.calculate(), "7")
    }

    // MARK: - Test expressionIsCorrect property after each type of operand
    func testGivenCalculationEndWithPlusOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 +")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    func testGivenCalculationEndWithMinusOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 -")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    func testGivenCalculationEndWithMultiplicationOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 ×")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    func testGivenCalculationEndWithDivisionOperand_WhenExpressionIsCorrect_ThenReturnFalse() {
        addCalculation("3 ÷")
        XCTAssertFalse(arithmetics.canAddOperand)
    }

    // MARK: - Test if calculation has enough element to calculate
    func testGivenCalculationWithTwoElements_WhenExpressionHasEnoughElement_ThenReturnFalse() {
        addCalculation("45")
        XCTAssertFalse(arithmetics.expressionHasEnoughElement)
    }

    func testGivenCalculationWithThreeElements_WhenExpressionHasEnoughElement_ThenReturnTrue() {
        addCalculation("45 + 6")
        XCTAssertTrue(arithmetics.expressionHasEnoughElement)
    }

    // MARK: - Test canAddOperand property after each type of operand
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

    // MARK: - Test expressionHasResult property
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

    // MARK: - Test delete method
    func testGivenCalculationEndingWithInt_WhenDeleteElement_ThenCalculationWithoutLastElement() {
        addCalculation("3 + 5")
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "3 + ")
    }

    func testGivenEmptyCalculation_WhenDeleteElement_ThenNothing() {
        addCalculation("")
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "0")
    }

    func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationWithoutLastElement() {
        addCalculation("3 + ")
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "3")
    }

    func testGivenNothing_WhenDeleteElement_ThenKeepZero() {
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "0")
    }

    func testGivenCalculationWithOneElement_WhenDelete_ThenCalculationIsZero() {
        arithmetics.calculation = "3"
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "0")
    }

    func testGivenNilElement_WhenDelete_ThenReturnNil() {
        arithmetics.calculation = ""
        arithmetics.delete()
        XCTAssertEqual(arithmetics.calculation, "")
    }

    // MARK: - Test reset calculation
    func testGivenCalculationEndingWithOperand_WhenDeleteElement_ThenCalculationIsEmpty() {
        addCalculation("45 × 56")
        arithmetics.resetCalculation()
        XCTAssertEqual(arithmetics.calculation, "0")
    }

    // MARK: - Test replacing operand
    func testGivenCalculationEndingWithOperand_WhenAddOperand_ThenChangeOldOperandWithNewOperand() {
        arithmetics.calculation = "45 + "
        addCalculation("-")
        XCTAssertEqual(arithmetics.calculation, "45 - ")
    }

    // MARK: - Methods
    override func setUp() {
        super.setUp()
        arithmetics.resetCalculation()
    }

    func addCalculation(_ calculation: String) {
        let elements: [String] = calculation.split(separator: " ").map { "\($0)" }
        elements.forEach({ element in
            arithmetics.addElement(element)
        })
    }
}
