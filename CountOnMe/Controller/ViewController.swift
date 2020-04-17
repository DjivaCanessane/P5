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
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }

        if arithmetics.expressionHasResult {
            // Reset calculation
            reset()
        }
        appendToCalculationAndShowOnTextView(numberText)
    }

    @IBAction func tappedOperandButton(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        switch title {
        case "+": addOperandToCalculation(" + ")
        case "×": addOperandToCalculation(" × ")
        case "-": addOperandToCalculation(" - ")
        case "÷": addOperandToCalculation(" ÷ ")
        default: return
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard arithmetics.expressionIsCorrect else {
            return showErrorDialog(title: "Zéro!", message: "Entrez une expression correcte !")
        }

        guard arithmetics.expressionHasEnoughElement else {
            return showErrorDialog(title: "Zéro!", message: "Démarrez un nouveau calcul !")
        }
        // Calculate the result and show it
        let result: String = arithmetics.calculate()
        textView.text.append(" = \(result)")
    }

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = ""
    }

    func addOperandToCalculation(_ sign: String) {
        if arithmetics.canAddOperand {
            appendToCalculationAndShowOnTextView(sign)
        } else {
            showErrorDialog(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    func appendToCalculationAndShowOnTextView(_ toAppend: String) {
        arithmetics.calculation.append(toAppend)
        textView.text = arithmetics.calculation
    }

    func showErrorDialog(title: String, message: String) {
        let alertVC =
            UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func reset() {
        arithmetics.resetCalculation()
        textView.text = ""
    }
}
