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
        arithmetics.addElement(numberText)
        textView.text = arithmetics.calculation
    }

    @IBAction func tappedOperandButton(_ sender: UIButton) {
        guard let operand = sender.titleLabel?.text else { return }
        arithmetics.addElement(operand)
        textView.text = arithmetics.calculation
    }
    @IBAction func tappedResetButton(_ sender: Any) {
        arithmetics.resetCalculation()
        textView.text = arithmetics.calculation
    }

    @IBAction func tappedDeleteButton(_ sender: Any) {
        arithmetics.delete()
        textView.text = arithmetics.calculation
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard arithmetics.canAddOperand else {
            return showErrorDialog(title: "Zéro!", message: "Entrez une expression correcte !")
        }

        guard arithmetics.expressionHasEnoughElement else {
            return showErrorDialog(title: "Zéro!", message: "Démarrez un nouveau calcul !")
        }

        if textView.text.contains("=") {
            reset()
            return
        }
        // Calculate the result and show it
        let result: String = arithmetics.calculate()
        textView.text.append(" = \(result)")
    }

    // MARK: - Methods

    func showErrorDialog(title: String, message: String) {
        let alertVC =
            UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func reset() {
        arithmetics.resetCalculation()
        textView.text = arithmetics.calculation
    }

    // MARK: - LifeCycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = arithmetics.calculation
    }
}
