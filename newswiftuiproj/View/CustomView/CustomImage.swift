import SwiftUI

struct CustomImage: View, Equatable {
    let name: String              // image name
    let isSystem: Bool            // system image or asset
    var size: CGFloat? = nil        // default size
    var color: Color = .primary   // tint or foreground color
    var cornerRadius: CGFloat = 5

    var body: some View {
        Group {
            if isSystem {
                Image(systemName: name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .applySize(size)
                    .foregroundColor(color)
                    .cornerRadius(cornerRadius)
            } else {
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .applySize(size)
                    .foregroundColor(color)
                    .cornerRadius(cornerRadius)
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomImage(name: "globe", isSystem: true, size: 40, color: .blue)
        CustomImage(name: "my_asset", isSystem: false, size: 60)
    }
}

extension View {
    @ViewBuilder
    func applySize(_ size: CGFloat?) -> some View {
        if let size = size {
            self.frame(width: size, height: size)
        } else {
            self
        }
    }
}
