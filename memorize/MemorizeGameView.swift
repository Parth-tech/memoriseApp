//
//  MemorizeGameView.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/12/23.
//

import SwiftUI

struct MemorizeGameView: View {
  
  @ObservedObject var memorizeGameViewModel : MemorizeGameViewModel
  @State var currCount : Int = 4
    var body: some View {
      VStack{
        
        ScrollView {
          cards
            .animation(.default, value: memorizeGameViewModel.cards)
        }
        Spacer()
//        cardCountAdjuster
        Button ("shuffle"){
          memorizeGameViewModel.shuffle()
        }
        
      }
        .padding()
    }
  
  var cardCountAdjuster : some View{
    HStack{
      cardAdjuster(by: -1, icon: "rectangle.stack.fill.badge.minus", name: "Remove Card")
      Spacer()
      cardAdjuster(by: 1, icon: "rectangle.stack.fill.badge.plus", name: "Add Card")
    }
  }
  
  var cards : some View  {
    HStack {
      
      LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 0)], spacing : 0){
          ForEach(memorizeGameViewModel.cards){ card in
            CardView(card)
              .aspectRatio(2/3,contentMode: .fit)
              .padding(5)
              .onTapGesture {
                memorizeGameViewModel.choose(card)
              }
          }
        }
      
    }
    .foregroundColor(.pink)
  }
  
  
  func cardAdjuster(by offset: Int, icon image: String, name text: String) -> some View {
      Button(action: {
          alterCardCount(inc: offset)
      }) {
          Label(text, systemImage: image)
      }
      .disabled(currCount + offset < 1 || currCount + offset > memorizeGameViewModel.cards.count )
    }
  
    var cardAdder : some View {
      Button(action: {
          alterCardCount(inc: 1)
      }) {
          Label("Add Card", systemImage: "rectangle.stack.fill.badge.plus")
      }
    }
  
    func alterCardCount (inc: Int) -> Void {
      currCount += inc
      if currCount < 1 {
        currCount = 1
      }
      else if currCount > memorizeGameViewModel.cards.count {
        currCount = memorizeGameViewModel.cards.count
      }
    }
}


struct CardView: View{
  
  var card : MemoryGameModel<String>.Card
  
  init(_ card: MemoryGameModel<String>.Card) {
    self.card = card
  }
  
  var body: some View{
    ZStack{
      let base = RoundedRectangle(cornerRadius: 12)
      
      Group  {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text(card.content)
          .font(.system(size:150))
          .minimumScaleFactor(0.01)
          .aspectRatio(1,contentMode: .fit)
      }.opacity(card.isFaceUp ? 1 : 0)
      
      base.fill().opacity(card.isFaceUp ? 0 : 1)
      
    }
    .opacity(card.isMatches ? 0 : 1)
    
  }
}

struct MemorizeGameView_Previews: PreviewProvider {
    static var previews: some View {
      MemorizeGameView(memorizeGameViewModel:MemorizeGameViewModel())
    }
}
