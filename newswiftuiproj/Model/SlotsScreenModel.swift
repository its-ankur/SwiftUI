//
//  SlotsScreenModel.swift
//  newswiftuiproj
//
//  Created by Sequoia on 06/08/25.
//

import Foundation

class SlotsScreenModel: ObservableObject {
    @Published var symbols = ["apple", "star", "cherry", "mango"]
    //@State private var symbols = ["apple"]
    @Published var numbers = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    @Published var credits = 1000
    @Published var showWin = false
    @Published var winMessage = ""
    @Published var isButtonDisabled = false
    @Published var spinCount = 0
    @Published var showGameOver = false
    
    var bet = 5
    var deduct = 25
}
