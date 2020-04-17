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
    var arithmetics: Arithmetics!
    var calculation: String!

    // MARK: - Tests

    // MARK: - Methods
    override func setUp() {
        super.setUp()
        arithmetics = Arithmetics()
        calculation = ""
    }

    func splitElementAndAddtoArithmetics() {
        var elements: [String] {
            return calculation.split(separator: " ").map { "\($0)" }
        }
        for element in elements {
            arithmetics.calculation.append(element)
        }
    }
}
