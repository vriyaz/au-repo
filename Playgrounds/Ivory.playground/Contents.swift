// Playground - noun: a place where people can play

import UIKit


var str = "Hello, playground"


print(str)

var i = 25;

print(i);


// simple values

var myVariable = 42
myVariable = 50
let myConstant = 42

let implicitInteger = 70
let implicitDouble = 70.0
let explicitDouble: Double = 70

print (myVariable + myConstant + implicitInteger)
print (implicitDouble + explicitDouble)

let s = String(myVariable) // + String(explicitDouble)
print (s)

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
print (shoppingList)

shoppingList[1] = "bottle of water"
print (shoppingList)

var occupations = [
    "malcolm" : "captain",
    "kaylee" : "mechanic"
]
print (occupations)
occupations["jane"] = "public relations"
print (occupations)


var emptyArray = [String]()
var emptyDictionary = [String: Float]()

print (emptyArray)
print (emptyDictionary)

// control flow
let scores = [75, 43, 103, 87, 12]
var teamScore = 0

for score in scores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

teamScore

let optionalString: String? = "hello"
optionalString

optionalString == nil
optionalString

var optionalName: String? = "john"
var greeting = "hello"

if let name = optionalName {
    greeting = "hello, \(name)"
}
greeting


let interestingNumbers = [
    "prime" : [2, 3, 5, 7, 11, 13],
    "fibonacci" : [1, 1, 2, 3, 5, 8],
    "square" : [1, 4, 9, 16, 25]
]

var largest = 0
for (kind, numbers) in interestingNumbers {
    print (kind)
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
    print (largest)
}

largest

var json: JSON =  ["I":"am", "a":"json"]

json["name"] = JSON("new-name")
json[0] = JSON(1)

json

if let path = NSBundle.mainBundle().pathForResource("quotes", ofType: "json") {
    if let data = NSData(contentsOfFile: path) {
        let json = JSON(data: data, options: NSJSONReadingOptions.AllowFragments, error: nil)
        println("jsonData:\(json)")
        let key = "hello"
        let value = json["dict1"][1]["a2"]
        println("\(key)=\(value)")
        //println(NSString(format: "%s=%s", key, value.stringValue)) // doesnt work
        json["dict1"][1]["a2"].stringValue
    }
}
