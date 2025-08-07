//
//  CustomText.swift
//  SwiftUIProject
//
//  Created by Sequoia on 24/07/25.
//

import SwiftUI

struct CustomText: View, Equatable {
    
    var title: String = ""
    var font: Font = .callout
    var fontWeight: Font.Weight = .regular
    var textColor: Color = .black
    var textAlignment: TextAlignment = .center
    var lineLimit: Int = 1
    var allowTightening: Bool = true
    var minimumScaleFactor: CGFloat = 0.5
    var lineSpacing: CGFloat = 0
    var fontFamily: String = "Times New Roman"
    var fontSize: CGFloat = 20
    var cornerRadius: CGFloat = 0
    var backGround: Color = .clear
    var padding: EdgeInsets = EdgeInsets()
    
    var body: some View {
        Text(title)
            .scaledFont(name: fontFamily, size: fontSize)
            .fontWeight(fontWeight)
            .foregroundStyle(Color(textColor))
            .multilineTextAlignment(textAlignment)
            .lineLimit(lineLimit)
            .allowsTightening(allowTightening)
            .minimumScaleFactor(minimumScaleFactor)
            .lineSpacing(lineSpacing)
            .padding(padding)
            .background(backGround)
            .cornerRadius(cornerRadius)
    }
}

extension CustomText {
    static func headLine(_ text: LocalizedStringKey) -> CustomText {
        CustomText(
            font: .title2,
            fontWeight: .bold,
            textColor: .primary,
            textAlignment: .leading,
            lineLimit: 2,
            allowTightening: true,
            minimumScaleFactor: 0.8,
            lineSpacing: 4,
            fontFamily: "HelveticaNeue-Bold",
            fontSize: 30
        )
    }
    
    static func body(_ text: LocalizedStringKey) -> CustomText {
        CustomText(
            font: .body,
            fontWeight: .regular,
            textColor: .secondary,
            textAlignment: .leading,
            lineLimit: 3,
            allowTightening: true,
            minimumScaleFactor: 0.7,
            lineSpacing: 2
        )
    }
    
    static func caption(_ text: LocalizedStringKey) -> CustomText {
        CustomText(
            font: .caption,
            fontWeight: .light,
            textColor: .gray,
            textAlignment: .center,
            lineLimit: 1,
            allowTightening: true,
            minimumScaleFactor: 0.6,
            lineSpacing: 1
        )
    }
}

#Preview {
    CustomText(title: "Welcome h89jkm9uf9 iocuaejnfkcj 9jiokw k siowm klioj  d", fontWeight: .bold, textColor: .blue, textAlignment: .center, lineLimit: 3, allowTightening: true, minimumScaleFactor: 0.7, fontFamily: "HelveticaNeue-Bold", fontSize: 50, cornerRadius: 0)
}
