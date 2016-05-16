//: Playground - noun: a place where people can play

import UIKit

extension Array {
    func map<U>(transform: Element-> U) -> [U]{
        var result: [U] = []
        result.reserveCapacity(self.count)
        for x in self {
        result.append(transform(x))
        }
        return result
    }
}

var fibs = [Int]()

fibs = [0, 1221, 21, 3, 544, 5, 77, 8989]
//
//var squared: [Int] = []
//for fib in fibs {
//squared.append(fib*fib)
//}




var squared = fibs.map{fib in fib * fib}
print(squared)


var sorted = fibs.sort()
