import Foundation

let input = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let numbers = input.split(separator: "\n").compactMap { Int($0) }
let result = numbers.reduce(0, +)
print(result)
