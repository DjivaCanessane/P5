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
        var operationsToReduce = elements

        // Reduce all multiplication
        operationsToReduce = reduceAllMultiplication(operationsToReduce)

        // Reduce all division
        guard let operations = reduceAllDivision(operationsToReduce) else { return "impossible" }
        operationsToReduce = operations

        // Iterate over operations while an operand still here
        let result = calculateAdditionAndSubstraction(operationsToReduce)
        expressionHasResult = true
        return result
    }

    func calculateAdditionAndSubstraction(_ elementsToCalculate: [String]) -> String {
        var operationsToReduce = elementsToCalculate

        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operand !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        guard let result = operationsToReduce.first else { return "error" }
        return result
    }

    func reduceAllMultiplication(_ elementsToCalculate: [String]) -> [String] {
        var operationsToReduce = elementsToCalculate

        // Check if operationsToReduce contains multiplication operand
        var containsMultiplication: Bool {
            return operationsToReduce.contains("×")
        }

        // Check presence of multiplication or division to prioritize them
        while containsMultiplication {
            let operandIndex: Int = operationsToReduce.firstIndex(of: "×")!
            let left = Int(operationsToReduce[operandIndex - 1])!
            let right = Int(operationsToReduce[operandIndex + 1])!

            let result: Int = left * right

            for _ in 1...3 {
                operationsToReduce.remove(at: operandIndex - 1)
            }
            operationsToReduce.insert("\(result)", at: operandIndex - 1)
        }
        return operationsToReduce
    }

    func reduceAllDivision(_ elementsToCalculate: [String]) -> [String]? {
        var operationsToReduce = elementsToCalculate

        // Check if operationsToReduce contains multiplication operand
        var containsDivision: Bool {
            return operationsToReduce.contains("÷")
        }

        // Check presence of multiplication or division to prioritize them
        while containsDivision {
            let operandIndex: Int = operationsToReduce.firstIndex(of: "÷")!
            let left = Int(operationsToReduce[operandIndex - 1])!
            let right = Int(operationsToReduce[operandIndex + 1])!

            guard right != 0 else { return nil }
            let result: Int = left / right

            for _ in 1...3 {
                operationsToReduce.remove(at: operandIndex - 1)
            }
            operationsToReduce.insert("\(result)", at: operandIndex - 1)
        }
        return operationsToReduce
    }

    func resetCalculation() {
        expressionHasResult = false
        calculation = ""
    }
}
