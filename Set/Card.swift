//
//  Card.swift
//  Set
//
//  Created by Chao Lin on 5/24/20.
//  Copyright © 2020 Chao Lin. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier: Int
    let attribute: [Int]
    
    static var allPossibleCombinations = [[Int]]()
    
    static var identifierFactory = 0
    
    static func getUniqIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func assignAttribute() -> [Int] {
        if allPossibleCombinations.count == 0 {
            allPossibleCombinations = getAllCombinations()
        }
        let randomIndex = allPossibleCombinations.count.arc4random
        return allPossibleCombinations.remove(at: randomIndex)
    }
    
    static func getAllCombinations() -> [[Int]] {
        //[number, shape, color, shade]
        let arr = [[0, 1, 2], [0, 1, 2], [0, 1, 2], [0, 1, 2]]
        let N = arr.count //total number of arrays
        var indices = [Int](repeating: 0, count: N)
        var result = [[Int]]()
        var temp = [Int]()
        
        while true {
            for i in 0..<N {
                temp.append(arr[i][indices[i]])
            }
            result.append(temp)
            temp = [Int]()
            
            var next = N - 1
            while (next >= 0 && (indices[next]+1 >= arr[next].count)) {
                next -= 1
            }
          
            if next < 0 {
                result.shuffle()
                return result
            }
          
            indices[next] += 1
          
            for i in next+1..<N {
                indices[i] = 0
            }
        }
    }
    
    
    init() {
        self.identifier = Card.getUniqIdentifier()
        self.attribute = Card.assignAttribute()
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

