//
//  Deck.swift
//  Set
//
//  Created by Chao Lin on 7/11/20.
//  Copyright © 2020 Chao Lin. All rights reserved.
//

import Foundation

struct CardDeck {
    private var cardDeck = [Card]()
    
    init(_ totalNumOfCards : Int) {
        for _ in 1...totalNumOfCards {
            let card = Card() //card need to cutomized appearance
            cardDeck.append(card)
        }
        cardDeck.shuffle()
    }

    func isEmpty() -> Bool {
        return cardDeck.isEmpty;
    }
    
    mutating func removeLast() -> Card? {
        if !cardDeck.isEmpty {
            return cardDeck.removeLast()
        } else {
            return nil
        }
    }
}
