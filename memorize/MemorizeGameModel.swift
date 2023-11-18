//
//  MemorizeGameModel.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/17/23.
//

import Foundation
struct MemoryGameModel<CardContent> {
  private(set) var cards: Array<Card>
  
  init(numOfPairOfCards: Int, cardContentFactory : (Int) -> CardContent) {
    cards = []
    
    for pairIndex in 0 ..< numOfPairOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content))
      cards.append(Card(content: content))
    }
  }
  
  func choose(card: Card){
    
  }
  
  mutating func shuffle(){
    cards.shuffle()
  }
  
  struct Card {
    var isFaceUp: Bool = true
    var isMatches: Bool = false
    var content: CardContent
  }
}
