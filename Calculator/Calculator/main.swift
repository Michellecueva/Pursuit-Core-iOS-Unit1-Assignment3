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

func space() {
    print("")
}
func continuePlayingMessage() {
    print("Calculate again? yes or no?")
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


func isInputValid(arrayOfStrings: [String]) -> Bool {
    if arrayOfStrings.count != 5 {
        notValidMessage()
        space()
        return false
    }
    
    if !methods.contains(arrayOfStrings[0]) {
        notValidMessage()
        space()
        return false
    }
    
    let arrayOfFirstIndex = arrayOfStrings[1].components(separatedBy: ",")
    for i in arrayOfFirstIndex {
        guard Int(i) != nil else {
            notValidMessage()
            space()
            return false
        }
    }
    
    if !(arrayOfStrings[2] == "by") {
        notValidMessage()
        space()
        return false
    }
    
    if !symbols.contains(arrayOfStrings[3]) {
        notValidMessage()
        space()
        return false
    }
    
    guard Int(arrayOfStrings[4]) != nil else {
        notValidMessage()
        space()
        return false
    }
    return true
}

func buildAString(arr: [Any]) -> String{
    var string = ""
    
    for (index, num) in arr.enumerated() {
        if index == arr.count - 1 {
            string.append("\(num) ")
        } else{
            string.append("\(num), ")}
    }
    
    return string
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
        space()
    }
}



func gameOperator() {
    print("Give me a statement and I will give you the result")
    sleep(1)
    space()
    print(" Let's try! Ex. 10 ? 3")
    space()
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
        space()
    } else {
        notValidMessage()
        space()
        return
    }
    
    print("The result is \(result). Can you guess the operation used?")
    space()
    print("Guess the operator: \(buildAString(arr: arrayOfOperators))")
    
    let optionalUserInput = getInput()
    
    guard let UserInput = optionalUserInput else { exit(0) }
    
    if UserInput == randomOperator {
        print("Corect!")
        space()
    } else if !arrayOfOperators.contains(UserInput){
        notValidMessage()
        print("The correct answer was \(randomOperator)")
        space()
    } else {
        print("Sorry! The correct answer was \(randomOperator)")
        space()
    }
}





func highOrder() {
    
    print("Enter your higher order operation: \(buildAString(arr: methods))")
    space()
    print(" Ex. filter 1,5,2,7,3,4 by < 4 ")
    print(" Ex. reduce 1,5,2,7,3,4 by + 4 ")
    print(" Ex. map 1,5,2,7,3,4 by * 4 ")
    
    space()
    
    let optionalUserInput = getInput()
    
    guard var userInput = optionalUserInput else {return}
    userInput = userInput.lowercased()
    
    let userInputArr = userInput.components(separatedBy: " ")
    
    if !isInputValid(arrayOfStrings: userInputArr) {
        return
    }
    
    let arrayOfInts = buildingArrFromString(str: userInputArr[1])
    
    if userInputArr[0] == "filter" {
        
        if !(userInputArr[3] == ">") && !(userInputArr[3] == "<") {
            notValidMessage()
            space()
            return
        }
        
        if userInputArr[3] == ">" {
            let myFilteredArr = myFilter(inputArray: arrayOfInts,  filter: {$0 > Int(userInputArr[4])!})
            print(buildAString(arr: myFilteredArr))
            space()
        }

        if userInputArr[3] == "<" {
            let myFilteredArr = myFilter(inputArray: arrayOfInts,  filter: {$0 < Int(userInputArr[4])!})
            print(buildAString(arr: myFilteredArr))
            space()
        }
    }
    
    
    if userInputArr[0] == "reduce" {
        
        if !(userInputArr[3] == "*") && !(userInputArr[3] == "+") {
            notValidMessage()
            space()
            return
        }
        
        if userInputArr[3] == "*" {
            let myReducedArr = myReduce(inputArray: arrayOfInts, initial: Int(userInputArr[4])!, reduce: {$0 * $1})
            print(myReducedArr)
            space()
        }
        
        if userInputArr[3] == "+" {
            let myReducedArr = myReduce(inputArray: arrayOfInts, initial: Int(userInputArr[4])!, reduce: {$0 + $1})
            print(myReducedArr)
            space()
        }
    }
    
    if userInputArr[0] == "map" {
        
        if !(userInputArr[3] == "*") && !(userInputArr[3] == "/") {
            notValidMessage()
            space()
            return
        }
        
        if userInputArr[3] == "/" {
            let myMapArr = myMap(inputArray: arrayOfInts, map: {Double($0) / Double(userInputArr[4])!})
            print(buildAString(arr: myMapArr))
            space()
        }
        
        if userInputArr[3] == "*" {
            let myMapArr = myMap(inputArray: arrayOfInts, map: {$0 * Int(userInputArr[4])!})
            print(buildAString(arr: myMapArr))
            space()
        }
    }
}



var play = true
var secondChance = true

while play {
    print("Choose 1 (Regular Calc), 2 (Game) or 3 (Higher Order Functions)")
    
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
            if secondChance {
                notValidMessage()
                space()
                secondChance = false
                continue
            }
            play = false
    
    }
    
}
