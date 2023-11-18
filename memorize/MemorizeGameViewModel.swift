//
//  MemorizeGameViewModel.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/17/23.
//

import Foundation


/// For Method 1
//func createCardContent(forPairAtIndex index: Int) -> String {
//  return emojis[index]
//}

class MemorizeGameViewModel : ObservableObject {
  
  private static let emojis = ["🥳", "🥰", "🤕", "👽", "🧑🏼‍💻", "👰🏾", "🧎🏼‍♀️", "🐟", "🦔"]
//  var numberOfPairsOfCards : Int 
  /// Method 1 to Pass the closure: By writing an entirely separate function
//  private var model = MemoryGameModel<String>(numOfPairOfCards: 4, cardContentFactory: createCardContent)
  
  /// Method 2 In-Line Func
//  private var model = MemoryGameModel<String>(
//    numOfPairOfCards: 4,
//    cardContentFactory: { (index: Int) -> String in
//      return emojis[index]
//    }
//  )
  
  /// Method 3: In-line closure removing extra keywords
//  private var model = MemoryGameModel<String>(
//      numOfPairOfCards: 4,
//      cardContentFactory: { index in
//        return emojis[index]
//      }
//    )
  
  /// Method 4: TRAILING CLOSURE Syntax
  @Published private var model = createMemoryGame()
  
  private static func createMemoryGame() -> MemoryGameModel<String> {
    return MemoryGameModel<String>(numOfPairOfCards: 4) { index in
      if index < emojis.count {
        return emojis[index]
      }
      else {
        return "⁉️"
      }
    }
  }
    
  var cards: Array<MemoryGameModel<String>.Card>{
    return model.cards
  }
  
  func choose(_ card: MemoryGameModel<String>.Card){
    model.choose(card: card)
  }
  
  
  func shuffle(){
    model.shuffle()
  }
}
