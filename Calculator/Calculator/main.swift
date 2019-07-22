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
func continuePlayingMessage() {
    print("Calculate again? Yes or no?")
}

func notValidMessage() {
    print("Sorry! This is not valid")
}

func unbindOptionalStringInput() -> String {
    let optionalUserInput = getInput()
    guard var userInput = optionalUserInput else {
        notValidMessage()
        exit(0)
    }
    userInput = userInput.lowercased()
    return userInput
}

func getUserInput() -> [String]  {
    let optionalUserInput = getInput()
    guard let userInput = optionalUserInput else {
        print("Hey, you didn't anything")
        return []
    }
    
    let userInputArr = userInput.components(separatedBy: " ")
    if userInputArr.count != 3 {
        notValidMessage()
        return []
    }
    
    guard Double(userInputArr[0]) != nil else {
        notValidMessage()
        return []
    }
    
    guard Double(userInputArr[2]) != nil else {
        notValidMessage()
        return []
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

// return bool
func isInputValid(arrayOfStrings: [String]) -> Bool {
    if arrayOfStrings.count != 5 {
        notValidMessage()
        return false
    }
    
    if !methods.contains(arrayOfStrings[0]) {
        notValidMessage()
        return false
    }
    
    let arrayOfFirstIndex = arrayOfStrings[1].components(separatedBy: ",")
    for i in arrayOfFirstIndex {
        guard Int(i) != nil else {
            notValidMessage()
            return false
        }
    }
    
    if !(arrayOfStrings[2] == "by") {
        notValidMessage()
        return false
    }
    
    if !symbols.contains(arrayOfStrings[3]) {
        notValidMessage()
        return false
    }
    
    guard Int(arrayOfStrings[4]) != nil else {
        notValidMessage()
        return false
    }
    return true
}

func buildAString(arr: [Any]){
    var stringArr = ""
    
    for (index, num) in arr.enumerated() {
        if index == arr.count - 1 {
            stringArr.append("\(num) ")
        } else{
            stringArr.append("\(num), ")}
    }
    
    print(stringArr)
}

func buildingArrFromString(str:String) -> [Int] {
    
    var buildingArr = [Int]()
    
    let arrayOfFirstIndex = str.components(separatedBy: ",")
    for i in arrayOfFirstIndex {
        buildingArr.append(Int(i)!)
    }
    
    return buildingArr
}


func myFilter(inputArray: [Int], filter: (Int) -> Bool)  -> [Int] {
    
    let filteredArray = inputArray.filter(filter)
    return filteredArray
}

func myReduce(inputArray: [Int], initial: Int, reduce: (Int,Int) -> Int)  -> Int {
    let reducedArr = inputArray.reduce(initial,reduce)
    return reducedArr
}

func myMap(inputArray: [Int], map: (Int) -> Any)  -> [Any] {
    let mapArr = inputArray.map(map)
    return mapArr
}




func Calculator() {
    
   print("Enter your operation: Ex. 5 + 8")
    
    let userInputArr = getUserInput()
    
    if userInputArr == [] {
        return
    }

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
    
    if userInputArr == [] {
        return
    }
    
    let firstNum = Double(userInputArr[0])!
    let secNum = Double(userInputArr[2])!
    var result = Double()
    
    let randomOperator = arrayOfOperators.randomElement()!
    
    if userInputArr[1] == "?" {
        guard let closure = operations[randomOperator] else { exit(0)  }
        result = closure(firstNum, secNum)
    } else {
        notValidMessage()
        return
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

//gameOperator()



func highOrder() {
    
    print("choose filter, reduce, or map")
    
    let optionalUserInput = getInput()
    
    guard var userInput = optionalUserInput else {return}
    userInput = userInput.lowercased()
    
    let userInputArry = userInput.components(separatedBy: " ")
    
    if !isInputValid(arrayOfStrings: userInputArry) {
        return
    }
    
    let arrayOfInts = buildingArrFromString(str: userInputArry[1])
    
    if userInputArry[3] == ">" || userInputArry[3] == "<" {
        if userInputArry[3] == ">" {
            let myFilteredArr = myFilter(inputArray: arrayOfInts,  filter: {$0 > Int(userInputArry[4])!})
            buildAString(arr: myFilteredArr)
        }
        
        if userInputArry[3] == "<" {
            let myFilteredArr = myFilter(inputArray: arrayOfInts,  filter: {$0 < Int(userInputArry[4])!})
            buildAString(arr: myFilteredArr)
        }
        
    }
    
    if userInputArry[0] == "reduce" {
        
        if !(userInputArry[3] == "*") && !(userInputArry[3] == "+") {
            notValidMessage()
            return
        }
        
        if userInputArry[3] == "*" {
            let myReducedArr = myReduce(inputArray: arrayOfInts, initial: Int(userInputArry[4])!, reduce: {$0 * $1})
            print(myReducedArr)
        }
        
        if userInputArry[3] == "+" {
            let myReducedArr = myReduce(inputArray: arrayOfInts, initial: Int(userInputArry[4])!, reduce: {$0 + $1})
            print(myReducedArr)
        }
    }
    
    if userInputArry[0] == "map" {
        
        if !(userInputArry[3] == "*") && !(userInputArry[3] == "/") {
            notValidMessage()
            return
        }
        
        if userInputArry[3] == "/" {
            let myMapArr = myMap(inputArray: arrayOfInts, map: {Double($0) / Double(userInputArry[4])!})
            buildAString(arr: myMapArr)
        }
        
        if userInputArry[3] == "*" {
            let myMapArr = myMap(inputArray: arrayOfInts, map: {$0 * Int(userInputArry[4])!})
            buildAString(arr: myMapArr)
        }
    }
    
    
    
    
}

//highOrder()



var play = true

while play {
    print("choose 1(Regular Calc), 2 (Game) or 3 (Higher Order Functions)")
    
    var userInput = unbindOptionalStringInput()
 
    switch userInput {
        case "1":
            Calculator()
            continuePlayingMessage()
            userInput = unbindOptionalStringInput()
            if userInput == "no" {
                print("Come back soon!")
                play = false
            }
        case "2":
            gameOperator()
            continuePlayingMessage()
            userInput = unbindOptionalStringInput()
            if userInput == "no" {
                print("Come back soon!")
                play = false
            }
        case "3":
            highOrder()
            continuePlayingMessage()
            userInput = unbindOptionalStringInput()
            if userInput == "no" {
                print("Come back soon!")
                play = false
            }
            
        default:
            notValidMessage()
            play = false
    }
    
}
