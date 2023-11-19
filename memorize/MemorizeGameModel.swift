//
//  MemorizeGameModel.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/17/23.
//

import Foundation
struct MemoryGameModel<CardContent> where CardContent: Equatable {
  private(set) var cards: Array<Card>
  
  var indexOfOneAndOnlyFaceUpCard : Int?
  {
    get {
      return cards.indices.filter{ index in cards[index].isFaceUp }.only
    }
    
    set {
      return cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)}
    }
  }
  
  
  init(numOfPairOfCards: Int, cardContentFactory : (Int) -> CardContent) {
    cards = []
    
    for pairIndex in 0 ..< numOfPairOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content, id: "\(pairIndex+1)a"))
      cards.append(Card(content: content, id: "\(pairIndex+1)b"))
    }
  }
  
  
  
  mutating func choose(card: Card){
    print(card)
    if let chosenIndex = cards.firstIndex(where: { $0.id == card.id
//      chosenCard in
//        chosenCard.id == card.id
      // can also be written as where : {$0.id == card.id}
    }) {
      print("chosenIndex: \(chosenIndex)")
      if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatches {
        if let possibleMatchIndex = indexOfOneAndOnlyFaceUpCard {
          if cards[possibleMatchIndex].content == cards[chosenIndex].content {
            cards[chosenIndex].isMatches = true
            cards[possibleMatchIndex].isMatches = true
          }
        }
        else {
          indexOfOneAndOnlyFaceUpCard = chosenIndex
        }
        cards[chosenIndex].isFaceUp = true
      }
    }
  }
  
  func index(of: Card) -> Int? {
    for index in cards.indices {
      if cards[index].id == of.id {
        return index
      }
    }
    return nil
  }
  
  // Intent: To Shuffle Cards
  mutating func shuffle(){
    
    cards.shuffle()
    print(cards)
  }
  
  
  struct Card : Equatable, Identifiable, CustomDebugStringConvertible {
    var debugDescription: String {
      return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatches ? "matched" : "")"
    }
    
    
    
//    static func == (lhs: MemoryGameModel<CardContent>.Card, rhs: MemoryGameModel<CardContent>.Card) -> Bool {
//      return lhs.content == rhs.content && lhs.isMatches == rhs.isMatches && lhs.isFaceUp == rhs.isFaceUp
//    }
    
    var isFaceUp: Bool = false
    var isMatches: Bool = false
    var content: CardContent
    var id: String
  }
}


extension Array {
  var only : Element? {
    count == 1 ? first : nil
  }
}
