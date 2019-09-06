//
//  ViewController.swift
//  Calculator
//
//  Created by Tim Li on 4/9/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var display: UILabel!
    private var isTyping = false
    private var currentSymbol: String? = nil
    private var model = CalculatorModel()
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            //TODO: scientific display
            display.text = (newValue == newValue.rounded() ? String(format: "%.0f", newValue) : String(newValue))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction private func tapDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        display.text = (isTyping ? display.text! : "") + digit
        isTyping = true
    }
    
    @IBAction private func calOperation(_ sender: UIButton) {
        if isTyping {
            model.setOperand(operand: displayValue)
            isTyping = false
        }
        
        if let symbol = sender.currentTitle {
            model.calOperation(symble: symbol)
        }
        
        displayValue = model.result
    }
    
}

