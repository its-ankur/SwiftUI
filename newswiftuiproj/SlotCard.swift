//
//  SlotCard.swift
//  newswiftuiproj
//
//  Created by Sequoia on 01/08/25.
//

import SwiftUI

struct SlotCard: View {
    
    @Binding var symbol: String
    
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(20)
    }
}

#Preview {
    SlotCard(symbol: Binding.constant("apple"))
}
