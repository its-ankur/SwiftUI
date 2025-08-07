//
//  RgbBox.swift
//  newswiftuiproj
//
//  Created by Sequoia on 01/08/25.
//

import SwiftUI

struct RgbBox: View {
    
    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    
    var body: some View {
        VStack{
            Rectangle()
                .frame(width: 100, height: 100)
                .foregroundColor(Color(red: red / 255,green: green/255,blue: blue/255))
                .border(Color.black, width: 1)
            
            SliderView(value: $red, label: "Red")
            
            SliderView(value: $green, label: "Green")
            
            SliderView(value: $blue, label: "Blue")
        }
        .padding()
    }
}

#Preview {
    RgbBox()
}
