//
//  ViewController.swift
//  Set
//
//  Created by Chao Lin on 5/24/20.
//  Copyright © 2020 Chao Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var dealCardButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var score: UILabel!
    private var game = gameOfSet()
    
    private let numberOfShapes = [1, 2, 3]
    private let shapes = ["▲", "●", "■"]
    private let colors = [UIColor.red, UIColor.blue, UIColor.green]
    private let shades = [0, 0.15, 1] //alpha value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in cardButtons.indices {
            cardButtons[i].isEnabled = false
            cardButtons[i].layer.borderWidth = 0
            cardButtons[i].layer.borderColor = UIColor.white.cgColor
            cardButtons[i].setTitle(nil, for: .normal)
        }
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        startGameButton.isHidden = true
        score.isHidden = false
        dealCardButton.isHidden = false
        newGameButton.isHidden = false
        
        for i in cardButtons.indices {
            cardButtons[i].isEnabled = true
        }
        
        for i in game.cardsInGame.indices {
            cardButtons[i].layer.borderWidth = 1
            cardButtons[i].layer.borderColor = UIColor.black.cgColor
        }
        
        updateViewFromModel()
    }
    
    @IBAction func selectCard(_ sender: UIButton) {
        if let cardNum = cardButtons.firstIndex(of: sender) {
            if cardNum < game.cardsInGame.count {
                game.selectCard(at: cardNum)
                updateViewFromModel()
            }
        }
        
        if game.matchSet {
            for idx in game.curSelectedCards.values {
                cardButtons[idx].layer.borderColor = UIColor.green.cgColor
            }
        } else if game.curSelectedCards.count == 3 {
            for idx in game.curSelectedCards.values {
                cardButtons[idx].layer.borderColor = UIColor.red.cgColor
            }
        }
    }
    
    func updateViewFromModel() {
        score.text = "Score: \(game.score)"
        for index in game.cardsInGame.indices {
            let button = cardButtons[index]
            if let card = game.cardsInGame[index] {
                let numIdx = card.attribute[0]
                let shapeIdx = card.attribute[1]
                let colorIdx = card.attribute[2]
                let shadeIdx = card.attribute[3]
                
                let attributes: [NSAttributedString.Key : Any] = [
                    .strokeWidth : -1,
                    .foregroundColor : colors[colorIdx].withAlphaComponent(CGFloat(shades[shadeIdx])),
                    .strokeColor : colors[colorIdx],
                ]
                
                var cardShape = ""
                for _ in  1...numberOfShapes[numIdx] {
                    cardShape += String(shapes[shapeIdx])
                }
                
                let attributedString = NSAttributedString(string: "\(cardShape)", attributes: attributes)
                button.setAttributedTitle(attributedString, for: .normal)
                
                if let _ = game.curSelectedCards[card] {
                    button.layer.borderWidth = 3.0
                    //button.layer.borderColor = UIColor.red.cgColor
                } else {
                    button.layer.borderWidth = 0.5
                    button.layer.borderColor = UIColor.black.cgColor
                }
                button.titleLabel?.font = .systemFont(ofSize: 25)
            } else {
                button.layer.borderWidth = 0
                button.layer.borderColor = UIColor.white.cgColor
                button.setAttributedTitle(nil, for: .normal)
                button.setTitle(nil, for: .normal)
                button.isEnabled = false
            }
        }
    }
    
    func clearCardButton(at idx : Int) {
        cardButtons[idx].layer.borderWidth = 0
        cardButtons[idx].layer.borderColor = UIColor.white.cgColor
        cardButtons[idx].setAttributedTitle(nil, for: .normal)
        cardButtons[idx].setTitle(nil, for: .normal)
    }
  
    @IBAction func deal3MoreCards(_ sender: UIButton) {
        if game.cardsInGame.count < 24 || game.matchSet {
            game.deal3MoreCards()
            updateViewFromModel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game = gameOfSet()
        
        for i in cardButtons.indices {
            clearCardButton(at: i)
        }
        
        for i in game.cardsInGame.indices {
             cardButtons[i].layer.borderWidth = 1
             cardButtons[i].layer.borderColor = UIColor.black.cgColor
        }
        updateViewFromModel()
    }
}

