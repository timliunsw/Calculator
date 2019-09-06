//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Tim Li on 5/9/19.
//  Copyright © 2019 Tim Li. All rights reserved.
//

import Foundation

class CalculatorModel {
    private var accumulator = 0.0
    private var isTappedCal = false
    private let operations: Dictionary<String, Operation> = [
        "÷": Operation.Cal({ $0 / $1 }),
        "×": Operation.Cal({ $0 * $1 }),
        "−": Operation.Cal({ $0 - $1 }),
        "+": Operation.Cal({ $0 + $1 }),
        "±": Operation.Reverse({ -$0}),
        "=": Operation.Equals,
        "C": Operation.Clear
    ]
    
    private enum Operation {
        case Cal((Double, Double) -> Double)
        case Reverse((Double) -> Double)
        case Equals
        case Clear
    }
    
    private struct PendingOperationInfo {
        var calFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    private var pending: PendingOperationInfo?
    
    func setOperand(operand: Double) {
        accumulator = operand
        isTappedCal = false
    }
    
    func calOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Cal(let cal):
                if isTappedCal {
                    pending = nil
                }
                executeCalculation()
                pending = PendingOperationInfo(calFunction: cal, firstOperand: accumulator)
                isTappedCal = true
            case .Reverse(let reverse):
                accumulator = reverse(accumulator)
            case .Equals:
                executeCalculation()
            case .Clear:
                pending = nil
                accumulator = 0
            }
        } 
    }
    
    private func executeCalculation() {
        if pending != nil {
            accumulator = pending!.calFunction(pending!.firstOperand, accumulator)
            pending = nil
            isTappedCal = false
        }
    }
    
    var result: Double {
        get {
            return accumulator;
        }
    }
}
