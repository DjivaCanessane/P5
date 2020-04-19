//
//  Arithmetics.swift
//  CountOnMe
//
//  Created by Djiva Canessane on 17/04/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Arithmetics {
    var calculation: String = ""

    var elements: [String] {
        return calculation.split(separator: " ").map { "\($0)" }
    }

    var operationsToReduce: [String] = []

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

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

        // Reduce all multiplication
        reduceAllMultiplication()

        // Reduce all division
        if let errorDivisionByZero = reduceAllDivision() {
            return errorDivisionByZero
        } else {
            // Iterate over operations while an operand still here
            let result = calculateAdditionAndSubstraction()
            expressionHasResult = true
            return result
        }
    }

    private func reduceAllMultiplication() {

        // Check if operationsToReduce contains multiplication operand
        var containsMultiplication: Bool {
            return operationsToReduce.contains("×")
        }

        // Check presence of multiplication or division to prioritize them
        while containsMultiplication {
            let operandIndex: Int = operationsToReduce.firstIndex(of: "×")!
            let result: String = performOperation(operandIndex)
            replacePriorOperationByResult(operandIndex - 1, result)
        }
    }

    private func reduceAllDivision() -> String? {

        // Check if operationsToReduce contains multiplication operand
        var containsDivision: Bool {
            return operationsToReduce.contains("÷")
        }

        // Check presence of multiplication or division to prioritize them
        while containsDivision {
            let operandIndex = operationsToReduce.firstIndex(of: "÷")!
            let result: String = performOperation(operandIndex)
            if result == "impossible" {
                return result
            }
            replacePriorOperationByResult(operandIndex - 1, result)
        }
        return nil
    }

    private func calculateAdditionAndSubstraction() -> String {
        while operationsToReduce.count > 1 {
            let result: String = performOperation(1)
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
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
        let operand: String = operationsToReduce[indexOfOperand]
        let left = Int(operationsToReduce[indexOfOperand - 1])!
        let right = Int(operationsToReduce[indexOfOperand + 1])!

        //Prevents division by zero
        guard operand != "÷" || right != 0 else { return "impossible" }

        let result: Int
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        case "÷": result = left / right
        case "×": result = left * right
        default: fatalError("Unknown operand !")
        }

        return String(result)
    }

    func resetCalculation() {
        expressionHasResult = false
        calculation = ""
    }
}
