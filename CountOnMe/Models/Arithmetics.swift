//
//  Arithmetics.swift
//  CountOnMe
//
//  Created by Djiva Canessane on 17/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Arithmetics {
    var calculation: String = "0"

    var elements: [String] {
        return calculation.split(separator: " ").map { "\($0)" }
    }

    var operationsToReduce: [String] = []

    // Check if the calculation do not finsh whith an operand
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    // Check if we can calculate
    var expressionHasEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperand: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    var expressionHasResult: Bool = false

    func calculate() -> String {
        // Create local copy of operations
        operationsToReduce = elements

        // Check if calculation do not start with multiply or divide operand
        var startWithMultiplicationOrDivision: Bool {
            operationsToReduce[0] == "×" || operationsToReduce[0] == "÷"
        }
        if startWithMultiplicationOrDivision { return "impossible" }

        // Reduce all multiplication
        reduceAllMultiplication()

        // Reduce all division
        if let errorDivisionByZero = reduceAllDivision() {
            return errorDivisionByZero
        }
        // Iterate over operations while an operand still here
        let result = calculateAdditionAndSubstraction()
        expressionHasResult = true
        return result
    }

    private func reduceAllMultiplication() {

        // Check if operationsToReduce contains multiplication operand
        var containsMultiplication: Bool {
            return operationsToReduce.contains("×")
        }

        // Check presence of multiplication to prioritize them
        while containsMultiplication {
            //TODO CHECK
            let operandIndex: Int = operationsToReduce.firstIndex(of: "×")!
            let result: String = performOperation(operandIndex)
            replacePriorOperationByResult(operandIndex - 1, result)
        }
    }

    private func reduceAllDivision() -> String? {

        // Check if operationsToReduce contains division operand
        var containsDivision: Bool {
            return operationsToReduce.contains("÷")
        }

        // Check presence of division to prioritize them
        while containsDivision {
            //TODO CHECK
            let operandIndex = operationsToReduce.firstIndex(of: "÷")!
            let result: String = performOperation(operandIndex)

            //return "impossible" while dividing by zero
            if result == "impossible" {
                return result
            }
            replacePriorOperationByResult(operandIndex - 1, result)
        }
        return nil
    }

    private func calculateAdditionAndSubstraction() -> String {
        while operationsToReduce.count > 1 && operationsToReduce.count > 2 {
            let result: String = performOperation(1)
            // check if calculation start with operand
            if Int(operationsToReduce[1]) != nil {
                // if so drop four elements
                operationsToReduce = Array(operationsToReduce.dropFirst(4))
            } else {
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
            }
            operationsToReduce.insert(result, at: 0)
        }
        guard let result = operationsToReduce.first else { return "error" }
        return result
    }

    private func replacePriorOperationByResult(_ atIndex: Int, _ with: String) {
        for _ in 1...3 {
            operationsToReduce.remove(at: atIndex)
        }
        operationsToReduce.insert(with, at: atIndex)
    }

    private func performOperation(_ indexOfOperand: Int) -> String {
        let operand: String
        let left: Float
        let right: Float
        let result: Float

        //verify if calculation start wign operand
        if Int(operationsToReduce[indexOfOperand]) != nil {
            operand = operationsToReduce[indexOfOperand + 1]
            guard let floatLeft =
                Float(operationsToReduce[indexOfOperand - 1] + operationsToReduce[indexOfOperand])
                else { return "error" }
            left = floatLeft

            guard let floatRight =
                Float(operationsToReduce[indexOfOperand + 2])
                else { return "error" }
            right = floatRight
        } else {
            operand = operationsToReduce[indexOfOperand]
            guard let floatLeft =
                Float(operationsToReduce[indexOfOperand - 1])
                else { return "error" }
            left = floatLeft

            guard let floatRight =
                Float(operationsToReduce[indexOfOperand + 1])
                else { return "error" }
            right = floatRight
        }

        //Prevents division by zero
        guard operand != "÷" || right != 0 else { return "impossible" }

        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "÷": result = left / right
        case "×": result = left * right
        default: return "Unknown operand !"
        }
        // if result have decimal part nul then convert to Int
        return floor(result) == result ? String(Int(result)) : String(result)
    }

    func delete() {
        // Ensure that the calculation will not reset when taping number Button
        expressionHasResult = false

        guard let lastChar = calculation.last else { return }
        guard lastChar == " " else {
            calculation = String(calculation.dropLast())
            return
        }
        calculation = String(calculation.dropLast(3))
        return
    }

    func resetCalculation() {
        expressionHasResult = false
        calculation = "0"
    }

    func addElement(_ element: String) {
        // When addind a integer we replace the initial zero
        if calculation == "0" && Int(element) != nil {
            calculation = String(calculation.dropLast())
            calculation.append(element)
            return
        } else if Int(element) != nil {
            calculation.append(element)
        } else {
            switch element {
            case "+": addOperandToCalculation(" + ")
            case "×": addOperandToCalculation(" × ")
            case "-": addOperandToCalculation(" - ")
            case "÷": addOperandToCalculation(" ÷ ")
            default: return
            }
        }
    }

    func addOperandToCalculation(_ sign: String) {
        if canAddOperand {
            calculation.append(sign)
        } else {
            calculation = String(calculation.dropLast())
            calculation.append(sign)
        }
    }
}
