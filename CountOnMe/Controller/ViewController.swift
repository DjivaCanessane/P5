//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    // MARK: - Properties

    let arithmetics: Arithmetics = Arithmetics()
    // MARK: - Actions

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }
        arithmetics.addElement(numberText)
    }

    @IBAction func tappedOperandButton(_ sender: UIButton) {
        guard let operand = sender.titleLabel?.text else { return }
        arithmetics.addElement(operand)
    }
    @IBAction func tappedResetButton(_ sender: Any) {
        arithmetics.resetCalculation()
    }

    @IBAction func tappedDeleteButton(_ sender: Any) {
        arithmetics.delete()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        // Calculate the result
        arithmetics.calculate()
    }

    // MARK: - Methods

    func showErrorAlert(title: String, message: String) {
        let alertVC =
            UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    // MARK: - LifeCycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        arithmetics.errorDelegate = self
        arithmetics.calculationDelegate = self
    }
}

// MARK: - Extension ArithmeticsCalculationDelegate
extension ViewController: ArithmeticsCalculationDelegate {
    // Show the result
    func calculationUpdated(_ calculation: String) {
        textView.text = calculation
    }
}

// MARK: - Extension ArithmeticsErrorsHandlingDelegate
extension ViewController: ArithmeticsErrorsHandlingDelegate {

    func errorMissingElements() {
        return showErrorAlert(title: "Zéro!", message: "Entrez une expression correcte !")
    }

    func errorNothingToCalculate() {
        return showErrorAlert(title: "Zéro!", message: "Démarrez un nouveau calcul !")
    }
}
