//
//  ViewController.swift
//  ProjectCalculator
//
//  Created by Jaspreet Pahal on 11/22/20.
//  Copyright © 2020 Jaspreet Pahal. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    var oper: Operator?
    var num1: Decimal = 0
    var num2: Decimal?
    
    var isDecimalEnabled = false
    var decimalCount: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func digitPressed(_ sender: UIButton) {
        var digit = Decimal(string: sender.currentTitle!)!
        if isDecimalEnabled {
            if oper != nil && num2 == nil {
                decimalCount = 0
            }
            
            decimalCount += 1
            digit /= pow(10, decimalCount)
        }
        
        if oper == nil {
            if !isDecimalEnabled {
                num1 *= 10
            }
            num1 += digit
        } else {
            if !isDecimalEnabled {
                num2 = (num2 ?? 0) * 10
            }
            num2 = (num2 ?? 0) + digit
        }
        
        updateResult()
    }
    
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        if oper == nil {
            isDecimalEnabled = false
        }
        oper = Operator(rawValue: sender.currentTitle!)
    }
    
    
    @IBAction func clearPressed(_ sender: Any) {
        num1 = 0
        num2 = nil
        oper = nil
        
        isDecimalEnabled = false
        decimalCount = 0
        
        updateResult()
    }
    
    
    @IBAction func execute(_ sender: Any) {
        if num2 == nil {
            return
        }
        
        switch oper {
        case .plus:
            num1 = num1 + num2!
        case .minus:
            num1 = num1 - num2!
        case .multiply:
            num1 = num1 * num2!
        case .divide:
            num1 = num1 / num2!
        case .none:
            return
        }
        
        oper = nil
        num2 = nil
        
        updateResult()
    }
    
    func updateResult() {
        let value = num2 ?? num1
        resultLabel.text = (value as NSDecimalNumber).stringValue
    }
    
    
    @IBAction func changeSign(_ sender: Any) {
        if num2 != nil {
            num2! *= -1
        } else {
            num1 *= -1
        }
        updateResult()
    }
    
    
    @IBAction func percentPressed(_ sender: Any) {
        if num2 != nil {
            num2! /= 100
        } else {
            num1 /= 100
        }
        updateResult()
    }
    
    
    @IBAction func enableDecimal(_ sender: Any) {
        isDecimalEnabled = true
        updateResult()
    }
}

enum Operator: String{
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "÷"
}

