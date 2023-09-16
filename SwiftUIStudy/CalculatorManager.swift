//
//  CalculatorManager.swift
//  SwiftUIStudy
//
//  Created by 문인범 on 2023/09/13.
//

import Foundation
import SwiftUI


class CalculatorManager: ObservableObject {
    @Published private var _display: String = "0"
    @Published public var selectedOperator: String = ""
    
    private var firstNums: Int = 0
    private var secondNums: Int = 0
    private var isOperatorSelected: Bool = false
    
    public var display: String {
        get {
            return _display
        }
        set {
            if _display == "0" {
                _display = ""
            }
            _display += newValue
        }
    }
    
    public func test(_ button: String) {
        if self.selectedOperator != "" {
            if !isOperatorSelected {
                self.firstNums = Int(display)!
                _display = "0"
            }
            self.isOperatorSelected = true
        }
        display = button
    }
    
    public func pressButton(_ button: String) {
        switch button {
        case "AC":
            self._display = "0"
            self.selectedOperator = ""
            self.firstNums = 0
            self.secondNums = 0
        case "+/-":
            self.selectedOperator = ""
        case "=":
            equalOperator()
        case "+", "-", "x", "/":
            self.selectedOperator = button
        default:
            self.test(button)
        }
    }
    
    private func equalOperator() {
        var result: Int = 0
        
        self.secondNums = Int(display)!
        
        switch self.selectedOperator {
        case "+": result = self.firstNums + self.secondNums
        case "-": result = self.firstNums - self.secondNums
        case "x": result = self.firstNums * self.secondNums
        case "/": result = self.firstNums / self.secondNums
        default: result = 0
        }
        
        self._display = String(result)
        self.firstNums = result
        self.secondNums = 0
        self.selectedOperator = ""
        self.isOperatorSelected = false
        
    }
    
}
