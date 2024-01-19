import UIKit

var greeting = "Hello, playground"


extension String.StringInterpolation {
    mutating func appendInterpolation(format value: Int, using style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        
        if let result = formatter.string(from: value as NSNumber){
            appendLiteral(result)
        }
        
    }
    
    mutating func appendInterpolation(format value: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        
        let result = formatter.string(from: value)
        appendLiteral(result)
    }
    
    
    mutating func appendInterpolation(_ values: [String], empty defaultValue: @autoclosure() -> String) {
        if values.count == 0 {
            appendLiteral(defaultValue())
        } else {
            appendLiteral(values.joined(separator: ", "))
        }
        
    }
    
    mutating func appendInterpolation<T: Encodable>(debug value: T) throws{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let result = try encoder.encode(value)
        let str = String(decoding: result, as: UTF8.self)
        appendLiteral(str)
    }
}

struct ToBePrettyPrinted: Encodable {
    var first: String
    var second: String
}

struct Regular {
    var first: String
    var second: String
}


let age = 38

print("Hi my age is \(age)")
print("Hi my age is \(format: age, using: .spellOut)")

print("Today's date is \(Date())")
print("Today's date is \(format: Date())")


let names = ["Marta", "Aga", "Kasia"]

print("My friends names are: \(names, empty: "Noone")")

let pretty = ToBePrettyPrinted(first: "first", second: "second")
let regular = Regular(first: "first", second: "second")

print(try "Nicely look into the object: \(debug: pretty)")
print("Just look into the object: \(regular)")
