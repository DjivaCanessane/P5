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
    var arithmetics: Arithmetics!
    var calculation: String!

    override func setUp() {
        super.setUp()
        arithmetics = Arithmetics()
        calculation = ""
    }
}
