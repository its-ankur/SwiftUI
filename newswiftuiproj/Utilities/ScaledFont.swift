//
//  ScaledFont.swift
//  SwiftUIProject
//
//  Created by Sequoia on 28/07/25.
//

import Foundation
import SwiftUI

struct ScaledFont: ViewModifier {
    let name: String
    let size: CGFloat

    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

extension View {
    func scaledFont(name: String, size: CGFloat) -> some View {
        self.modifier(ScaledFont(name: name, size: size))
    }
}
