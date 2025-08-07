//
//  SlotCard.swift
//  newswiftuiproj
//
//  Created by Sequoia on 01/08/25.
//

import SwiftUI

struct SlotCard: View, Equatable {
    
    static func == (lhs: SlotCard, rhs: SlotCard) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    @Binding var symbol: String
    
    var body: some View {
        CustomImage(name: symbol, isSystem: false, cornerRadius: 20)
    }
}

#Preview {
    SlotCard(symbol: Binding.constant("apple"))
}
