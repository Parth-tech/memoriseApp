//
//  ContentView.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: false)
            CardView(isFaceUp: false)
        }
        .foregroundColor(.pink)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View{
  @State var isFaceUp = false
  
  var body: some View{
    ZStack{
      let base = RoundedRectangle(cornerRadius: 12)
      
      if isFaceUp  {
        base.fill(.white)
        base.strokeBorder(lineWidth: 2)
        Text("☢︎").font(.largeTitle)
      }
      else{
        base.fill()
      }
      
    }
    .onTapGesture {
      isFaceUp = !isFaceUp
    }
  }
}
