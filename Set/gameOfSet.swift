//
//  Set.swift
//  Set
//
//  Created by Chao Lin on 5/24/20.
//  Copyright © 2020 Chao Lin. All rights reserved.
//

import Foundation

class gameOfSet {
    
    private let totalNumOfCards = 81
    lazy var cardDeck = CardDeck(totalNumOfCards)
    var cardsInGame = [Card?]()
    var score : Int
    var matchedCards = [Card]()
    var curSelectedCards = [Card : Int]()
    var matchSet : Bool { //closure example
        let selectedCards = Array(curSelectedCards.keys)
        var matched = false
        if curSelectedCards.count == 3 {
            for i in selectedCards[0].attribute.indices {
                //each feature must either be the same or different 3 cards
                if (selectedCards[0].attribute[i] == selectedCards[1].attribute[i] &&
                    selectedCards[0].attribute[i] == selectedCards[2].attribute[i]) ||
                    (selectedCards[0].attribute[i] != selectedCards[1].attribute[i] &&
                    selectedCards[0].attribute[i] != selectedCards[2].attribute[i] &&
                    selectedCards[1].attribute[i] != selectedCards[2].attribute[i]) {
                    matched = true
                } else {
                    matched = false
                    break
                }
            }
        }
        return matched
    }
    
    func selectCard(at index: Int) {
        let listOfSelectedIndices = Array(curSelectedCards.values)
        checkMatchAndUpdate()
        //update selected cards
        if let _ = curSelectedCards[cardsInGame[index]!] {
            if curSelectedCards.count < 3 {
                score -= 1
                curSelectedCards[cardsInGame[index]!] = nil
            }
        } else if !listOfSelectedIndices.contains(index) {
            curSelectedCards[cardsInGame[index]!] = index
        }
    }
    
    private func checkMatchAndUpdate() {
        if curSelectedCards.count == 3 {
            if matchSet {
                score += 3
                for (card, idx) in curSelectedCards
                {
                    matchedCards.append(card)
                    if !cardDeck.isEmpty() {
                        cardsInGame[idx] = cardDeck.removeLast()
                    } else {
                        cardsInGame[idx] = nil
                    }
                }
            } else {
                score -= 5
            }
            curSelectedCards = [Card : Int]()
        }
    }
    
    func deal3MoreCards() {
        if !cardDeck.isEmpty() {
            if matchSet{
                for idx in curSelectedCards.values {
                    cardsInGame[idx] = cardDeck.removeLast()
                }
            } else {
                for _ in 1...3 {
                    cardsInGame.append(cardDeck.removeLast())
                }
            }
            curSelectedCards = [Card : Int]()
        }
    }
    
    init() {
        score = 0
        for _ in 1...12 {
            cardsInGame.append(cardDeck.removeLast())
        }
    }
}
