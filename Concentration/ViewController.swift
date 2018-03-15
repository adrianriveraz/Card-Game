//
//  ViewController.swift
//  Concentration
//
//  Created by Adrian Rivera-Zayas on 2/19/18.
//  Copyright © 2018 Adrian Rivera-Zayas. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0
    {
        didSet
        {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton)
    {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender)
        {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else
        {
                print("card not in cardButtons")
        }
    }
    
    func updateViewFromModel()
    {
        for index in cardButtons.indices
        {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp
            {
                button.setTitle(emoji(for:card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0): #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
            }
        }
    }
    var emojiChoices = ["🌞", "🌚", "🌝", "💩", "🦇", "☠️","🤢","😇","😡", "😎", "🤩"]
    
    var emoji = [Int:String]()
    
    func emoji(for card:Card) -> String
    {
       /* if chosenEmoji = emoji[card.identifier] != nil
        {
            return emoji[card.identifier]
        }
        else
        {
                    return "?"
        }
         */
        if emoji[card.identifier] == nil, emojiChoices.count > 0
        {
     
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count-1)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
