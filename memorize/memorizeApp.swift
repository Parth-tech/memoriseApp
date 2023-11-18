//
//  memorizeApp.swift
//  memorize
//
//  Created by Parth Rasu Jangid on 11/12/23.
//

import SwiftUI

@main
struct memorizeApp: App {
  
  @StateObject var memorizeGameViewModel = MemorizeGameViewModel()
    var body: some Scene {
        WindowGroup {
          MemorizeGameView(memorizeGameViewModel: memorizeGameViewModel)
        }
    }
}
