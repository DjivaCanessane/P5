//
//  ArithmeticsMockDelegate.swift
//  CountOnMe
//
//  Created by Samo Mpkamou on 10/06/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation
@testable import CountOnMe

class ArithmeticsDelegateMock: ArithmeticsCalculationDelegate {
    var mockCalculation: String = "0"
    func calculationUpdated(_ calculation: String) {
        mockCalculation = calculation
    }
}
