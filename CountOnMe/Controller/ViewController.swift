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

        if arithmetics.expressionHaveResult {
            textView.text = ""
        }
        appendToCalculationAndShow(numberText)
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if arithmetics.canAddOperator {
            appendToCalculationAndShow(" + ")
        } else {
            let alertVC =
                UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if arithmetics.canAddOperator {
            appendToCalculationAndShow(" - ")
        } else {
            let alertVC =
                UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard arithmetics.expressionIsCorrect else {
            let alertVC =
                UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }

        guard arithmetics.expressionHaveEnoughElement else {
            let alertVC =
                UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        // Calculate the result and show it
        let result: String = arithmetics.calculate()
        textView.text.append(" = \(result)")

        // Reset calculation
        arithmetics.calculation = ""
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
}
