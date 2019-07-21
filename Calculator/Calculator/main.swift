//
//  main.swift
//  Calculator
//
//  Created by Michelle Cueva on 7/18/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

var operations: ([String: (Double, Double) -> Double]) = ["+": { $0 + $1 },
                                                          "-": { $0 - $1 },
                                                          "*": { $0 * $1 },
                                                          "/": { $0 / $1 }]

var arrayOfOperators = [String]()

for keys in operations.keys {
    arrayOfOperators.append(keys)
}

let methods = ["filter", "reduce", "map"]

let symbols = ["<", ">", "*", "/", "+"]

func getInput() -> String? {
    let lineIn = readLine()
    return lineIn
}

func notValidMessage() {
    print("Sorry! This is not valid")
}

func getUserInput() -> [String]  {
    let optionalUserInput = getInput()
    guard let userInput = optionalUserInput else {
        print("Hey, you didn't anything")
        exit(0)
    }
    
    let userInputArr = userInput.components(separatedBy: " ")
    if userInputArr.count != 3 {
        notValidMessage()
        exit(0)
    }
    
    guard Double(userInputArr[0]) != nil else {
        notValidMessage()
        exit(0)
    }
    
    guard Double(userInputArr[2]) != nil else {
        notValidMessage()
        exit(0)
    }
    
    return userInputArr
}




func isAnOperation(userOperation: String) -> Bool {
    
    guard operations[userOperation] != nil else {
        notValidMessage()
        return false
    }
    return true
}

func isInputValid(arrayOfStrings: [String]){
    if arrayOfStrings.count != 5 {
        notValidMessage()
        exit(0)
    }
    
    if !methods.contains(arrayOfStrings[0]) {
        notValidMessage()
        exit(0)
    }
    
    let arrayOfFirstIndex = arrayOfStrings[1].components(separatedBy: ",")
    for i in arrayOfFirstIndex {
        guard Int(i) != nil else {
            notValidMessage()
            exit(0)
        }
    }
    
    if !(arrayOfStrings[2] == "by") {
        notValidMessage()
        exit(0)
    }
    
    if !symbols.contains(arrayOfStrings[3]) {
        notValidMessage()
        exit(0)
    }
    
    guard Int(arrayOfStrings[4]) != nil else {
        notValidMessage()
        exit(0)
    }
    
}



func Calculator() {
    
   print("Enter your operation: Ex. 5 + 8")
    
    let userInputArr = getUserInput()

    let firstNum = Double(userInputArr[0])!
    let secNum = Double(userInputArr[2])!
    let operatorSym = userInputArr[1]
    var result = Double()
    
    
    if isAnOperation(userOperation: operatorSym) {
        let closure = operations[operatorSym]!
        result = closure(firstNum, secNum)
        
        print("\(userInputArr.joined(separator: " ")) = \(result)")
    }
}

//Calculator()

func gameOperator() {
    print("Enter operation")
    
    let userInputArr = getUserInput()
    let firstNum = Double(userInputArr[0])!
    let secNum = Double(userInputArr[2])!
    var result = Double()
    
    let randomOperator = arrayOfOperators.randomElement()!
    
    if userInputArr[1] == "?" {
        guard let closure = operations[randomOperator] else { exit(0)  }
        result = closure(firstNum, secNum)
    } else {
        notValidMessage()
        exit(0)
    }
    
    print(result)
    
    print("Guess the operator")
    
    let optionalUserInput = getInput()
    
    guard let UserInput = optionalUserInput else { exit(0) }
    
    if UserInput == randomOperator {
        print("Corect!")
    } else {
        print("Sorry! The correct answer was \(randomOperator)")
    }
}

gameOperator()



func highOrder() {
    
    let optionalUserInput = getInput()
    
    guard var userInput = optionalUserInput else {exit(0)}
    userInput = userInput.lowercased()
    
    let userInputArry = userInput.components(separatedBy: " ")
    
    isInputValid(arrayOfStrings: userInputArry)
    
    if userInputArry[3] == ">" || userInputArry[3] == "<" {
        // my filter function here and pass in the parts of the array as arguments
    }
    
    if userInputArry[0] == "reduce" {
        
        if !(userInputArry[3] == "*") && !(userInputArry[3] == "+") {
            notValidMessage()
            exit(0)
        }
        
        // run reduce function
    }
    
    if userInputArry[0] == "map" {
        
        if !(userInputArry[3] == "*") && !(userInputArry[3] == "/") {
            notValidMessage()
            exit(0)
        }
        
        // run map function
    }
    
    
    
    
}

highOrder()
