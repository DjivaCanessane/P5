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
        appendToCalculationAndShow(numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if arithmetics.canAddOperator {
            appendToCalculationAndShow(" + ")
        } else {
            showErrorDialog(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedMultiplyButton(_ sender: Any) {
        if arithmetics.canAddOperator {
            appendToCalculationAndShow(" × ")
        } else {
            showErrorDialog(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedDivisionButton(_ sender: Any) {
        if arithmetics.canAddOperator {
            appendToCalculationAndShow(" ÷ ")
        } else {
            showErrorDialog(title: "Zéro!", message: "Un operateur est déja mis !")
        }
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if arithmetics.canAddOperator {
            appendToCalculationAndShow(" - ")
        } else {
            showErrorDialog(title: "Zéro!", message: "Un operateur est déja mis !")
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

    func appendToCalculationAndShow(_ toAppend: String) {
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
