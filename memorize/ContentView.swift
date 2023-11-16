//
//  ContentView.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["🥳", "🥰", "🤕", "👽", "🧑🏼‍💻", "👰🏾", "🧎🏼‍♀️", "🐟", "🦔"]
    @State var currCount: Int = 4
    var body: some View {
      VStack{
        
        ScrollView {
          cards
        }
        Spacer()
        cardCountAdjuster
        
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
      
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100)),GridItem(.adaptive(minimum: 100))]){
          ForEach(0..<currCount, id: \.self){ index in
            CardView(isFaceUp: true, cardContent: emojis[index])
              .aspectRatio(2/3,contentMode: .fit)
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
      .disabled(currCount + offset < 1 || currCount + offset > emojis.count )
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
      else if currCount > emojis.count {
        currCount = emojis.count
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View{
  @State var isFaceUp = false
  var cardContent: String = ""
  
  var body: some View{
    ZStack{
      let base = RoundedRectangle(cornerRadius: 12)
      
      Group  {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text(cardContent).font(.largeTitle)
      }.opacity(isFaceUp ? 1 : 0)
      
      base.fill().opacity(isFaceUp ? 0 : 1)
      
    }
    .onTapGesture {
      isFaceUp = !isFaceUp
    }
  }
}
