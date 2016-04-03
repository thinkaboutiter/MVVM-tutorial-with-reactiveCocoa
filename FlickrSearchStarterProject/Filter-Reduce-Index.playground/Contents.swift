//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let names: [String] = ["ivan", "ivan2", "ivan3", "ivan 1", "ivan s boyan", "boyan s ivan", "boyan"]

var evens = [Int]()

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

/**
 Filter
 */
evens = Array(1...10).filter(isEven)

evens = Array(1...10).filter { (number) in number % 2 == 0 }
evens = Array(1...10).filter({ (number) -> Bool in
    return (number % 2 == 0)
})


let res = names.filter { (string) -> Bool in
    string.containsString("ivan")
}

//debugPrint(res)

extension Array {
    func myFilter(predicate: (Element) -> Bool) -> [Element] {
        var result = [Element]()
        
        for item in self {
            if predicate(item) {
                result.append(item)
            }
        }
        
        return result
    }
}

let res2 = evens.myFilter { (item) -> Bool in
    item % 2 == 0
}

let res3 = names.myFilter { (item) -> Bool in
    item.containsString("boyan")
}

//debugPrint(res3)

/**
 Reduce
 
 func reduce<U>(initial: U, combine: (U, T) -> U) -> U
 
 */

var evenSum = Array(1...10)
    .filter { (number) in number % 2 == 0}
    .reduce(0) { (total, number) -> Int in
        total + number
}

let maxNumber = Array(1...10)
    .reduce(0) { (total, number) in max(total, number) }

let stringNubers = Array(1...10).reduce("") { (total, number) -> String in
    total + "\(number) "
}

let digits = ["3", "1", "4", "1"]

let res4 = digits.reduce(0) { (total, element) -> Int in
    total * 10 + Int(element)!
}


extension Array {
    func myReduce<U>(seed:U, combiner:(U, Element) -> U) -> U {
        var current = seed
        for item in self {
            current = combiner(current, item)
        }
        return current
    }
}

let res5 = digits.myReduce(0) { (total, element) -> Int in
    total * 10 + Int(element)!
}

/**
 Building an Index Imperatively
 */

let words = ["Cat", "Chicken", "fish", "Dog",
             "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func buildIndexImeprative(words: [String]) -> [Entry] {
    var result = [Entry]()
    
    var letters = [Character]()
    for word in words {
        let firstLetter = Character(word.uppercaseString.substringToIndex(word.startIndex.advancedBy(1)))
        
        if !letters.contains(firstLetter) {
            letters.append(firstLetter)
        }
    }
    
    for letter in letters {
        var wordsForLetter = [String]()
        for word in words {
            let firstLetter = Character(word.uppercaseString.substringToIndex(word.startIndex.advancedBy(1)))
            
            if firstLetter == letter {
                wordsForLetter.append(word)
            }
        }
        result.append((letter, wordsForLetter))
    }
    return result
}

let res6 = buildIndexImeprative(words)
//debugPrint(res6)

/**
 Building an Index the Functional Way
 */

extension Array where Element: Equatable {
    func distinct() -> [Element] {
        var unique = [Element]()
        for item in self {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }
}

extension String {
    func firstCharacter() -> Character {
        return Character(self.uppercaseString.substringToIndex(self.startIndex.advancedBy(1)))
    }
}

func buildIndexFunctional(words: [String]) -> [Entry] {
    let letters = words.map { (word) -> Character in
        word.firstCharacter()
    }.distinct().sort()
    
    
    return letters.map({ (letter) -> Entry in
        return (letter, words.filter({ (word) -> Bool in
            word.firstCharacter() == letter
        }))
    })
}

let res7 = buildIndexFunctional(words)

debugPrint(res7)




