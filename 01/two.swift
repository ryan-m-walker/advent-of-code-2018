import Foundation

let input = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let numbers = input.split(separator: "\n").compactMap { Int($0) }

var seen: Set<Int> = [0]
var frequency = 0

outer: while true {
    for number in numbers {
        frequency += number
        if seen.contains(frequency) {
            print(frequency)
            break outer
        }
        seen.insert(frequency)
    }
}
