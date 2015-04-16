//
//  ViewController.swift
//  Calculator
//
//  Created by Riyaz Vali on 4/8/15.
//  Copyright (c) 2015 Riyaz Vali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsStillTyping = false
    var brain = CalculatorBrain()

    @IBAction func append(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsStillTyping {
            if (digit == "." && display.text?.rangeOfString(".") == nil) || (digit != ".") {
                display.text = display.text! + digit;
            }
        } else {
            if digit == "." {
                display.text = "0."
            } else {
                display.text = digit
            }
            userIsStillTyping = true
        }
    }

    var operandStack = Array<Double>()

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsStillTyping = false
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        println("operation = \(operation)")

        if userIsStillTyping {
            enter()
        }
/*
        switch operation {
        case "×": performOperation { $1 * $0 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $1 + $0 }
        case "−": performOperation { $1 - $0 }
        case "√": doOperation { sqrt($0) }
        default:
            break
        }
*/
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
/*
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

    func doOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
*/
    @IBAction func enter() {
        userIsStillTyping = false
/*
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
*/
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue  = 0
        }

    }
}

