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
        calculation.split(separator: " ").map { "\($0)" }
    }

    var operationsToReduce: [String] = []

    // Check if we can calculate
    var expressionHasEnoughElement: Bool {
        elements.count >= 3
    }

    var canAddOperand: Bool {
        elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    var expressionHasResult: Bool = false

    func calculate() -> String {
        // Create local copy of operations
        operationsToReduce = elements

        // Make all divisions and multiplications
        makePriorOperations()
        // Iterate over operations while an operand still here
        let result = calculateAdditionAndSubstraction()
        expressionHasResult = true
        return result
    }

    private func makePriorOperations() {
        while let priorOperandIndex = hasPriorOperation() {
            let result: String = performOperation(priorOperandIndex)
            replaceOperationByResult(priorOperandIndex - 1, result)
        }
    }

    private func calculateAdditionAndSubstraction() -> String {
        while operationsToReduce.count > 2 {
            let result: String = performOperation(1)
            replaceOperationByResult(0, result)
        }
        guard let result = operationsToReduce.first else { return "error" }
        return result
    }

    private func replaceOperationByResult(_ atIndex: Int, _ with: String) {
        for _ in 1...3 {
            operationsToReduce.remove(at: atIndex)
        }
        operationsToReduce.insert(with, at: atIndex)
    }

    private func performOperation(_ indexOfOperand: Int) -> String {
        let result: Float

        let operand: String = operationsToReduce[indexOfOperand]
        guard let left =
            Float(operationsToReduce[indexOfOperand - 1])
            else { return "error" }

        guard let right =
            Float(operationsToReduce[indexOfOperand + 1])
            else { return "error" }

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

    private func hasPriorOperation() -> Int? {
        if let multiplicationIndex = operationsToReduce.firstIndex(of: "×") {
            return multiplicationIndex
        } else if let divisionIndex = operationsToReduce.firstIndex(of: "÷") {
            return divisionIndex
        }
        return nil
    }

    func delete() {
        // Ensure that the calculation will not reset when taping number Button
        expressionHasResult = false
        guard calculation != "0" else { return }
        guard let lastChar = calculation.last else { return }
        guard String(lastChar) != calculation else { return calculation = "0" }
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
            calculation = String(calculation.dropLast(3))
            calculation.append(sign)
        }
    }
}
