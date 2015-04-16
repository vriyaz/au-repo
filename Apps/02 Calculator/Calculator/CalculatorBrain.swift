//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Riyaz Vali on 4/14/15.
//  Copyright (c) 2015 Riyaz Vali. All rights reserved.
//

import Foundation

class CalculatorBrain
{

    private enum Op: Printable { // enums dont inherit
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)

        var description: String { // must be a read-only compute property called description
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }

    private var opStack = [Op]()

    private var knownOps = [String:Op]()

    init() {

        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        //knownOps[√  × − ÷ +]

        //knownOps["×"] = Op.BinaryOperation("×", *) // * is a function
        learnOp(Op.BinaryOperation("/", {$1 / $0})) // using closures, cant use % coz order matters
        learnOp(Op.BinaryOperation("-", {$1 - $0})) // cant use - coz order matters
        learnOp(Op.BinaryOperation("*", *))
        learnOp(Op.BinaryOperation("+", +))
        learnOp(Op.UnaryOperation("√", sqrt)) // use existing function that matches the signature
    }

    func clear() {
        opStack = [Op]()
    }

    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }

    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        } else {
            if symbol == "AC" {
                self.clear()
            }
        }
        return evaluate()
    }

    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {

        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()

            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        return (operation(operand1, operand2), remainingOps)
                    }
                }

            }
        }
        return (nil, ops)
    }

    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack) // _ --> i dont care variable
        println("\(opStack) = \(result) with \(remainder) left over");
        return result
    }
}