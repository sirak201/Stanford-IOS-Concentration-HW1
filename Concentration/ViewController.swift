//
//  ViewController.swift
//  Concentration
//
//  Created by Sirak Zeray on 12/25/18.
//  Copyright © 2018 Sirak Zeray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    lazy var game = Concentration(numberOfPairs: (cardButtons.count + 1) / 2)
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    var emoji = [Int : String]()
    var emojiThemeSet = [["👌🏽","👈🏼","👉🏽","👆🏿","👇🏻","✋","🤙🏼"],["🐻","🐶","🐒","🦅","🐗","🦉"],["🌈","☀️","🌤","❄️","💦","🌊"],["🍏","🥥","🥝","🥦","🍆","🍠","🥐"]]
    var picketSet = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        picketSet = Int(arc4random_uniform(UInt32(emojiThemeSet.count)))
    }

    @IBAction func cardSelected(_ sender: UIButton) {
        game.flipCount += 1
        flipCountLabel.text = "Flip Count: \(game.flipCount) "
        if let cardNumber = cardButtons.index(of : sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        game = Concentration(numberOfPairs: (cardButtons.count + 1) / 2)
        scoreLabel.text = "Game Score : \(game.score)"
        flipCountLabel.text = "Flip Count: \(game.flipCount)"
        
        for index in cardButtons.indices{
            let button = cardButtons[index]
            button.setTitle("", for: .normal)
            button.backgroundColor =  #colorLiteral(red: 1, green: 0.5980759889, blue: 0.3937914143, alpha: 1)
        }
        emojiThemeSet = [["👌🏽","👈🏼","👉🏽","👆🏿","👇🏻","✋","🤙🏼"],["🐻","🐶","🐒","🦅","🐗","🦉"],["🌈","☀️","🌤","❄️","💦","🌊"],["🍏","🥥","🥝","🥦","🍆","🍠","🥐"]]
        picketSet = Int(arc4random_uniform(UInt32(emojiThemeSet.count)))
        emoji = [Int : String]()
        
    }
    
    func updateViewFromModel(){
        scoreLabel.text = "Game Score : \(game.score)"
        for index in cardButtons.indices{
            let card = game.cards[index]
            let button = cardButtons[index]
            
            if card.isFaceUp{
                button.setTitle(emoji(for : card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5980759889, blue: 0.3937914143, alpha: 1)
            }
        }
    }


    func emoji(for card : Card) -> String{
        
        if emoji[card.identifier] == nil , emojiThemeSet[picketSet].count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemeSet[picketSet].count)))
            emoji[card.identifier] = emojiThemeSet[picketSet].remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
}

