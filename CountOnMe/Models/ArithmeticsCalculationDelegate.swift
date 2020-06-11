//
//  ArithmeticsDelegate.swift
//  CountOnMe
//
//  Created by Samo Mpkamou on 10/06/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ArithmeticsCalculationDelegate: class {
    func calculationUpdated(_ calculation: String)
}

protocol ArithmeticsErrorsHandlingDelegate: class {
    func errorMissingElements()
    func errorNothingToCalculate()
}
