import SwiftUI

struct SliderView: View {
    
    @Binding var value: Double
    var label: String
    
    var body: some View {
        VStack {
            Slider(value: $value, in: 0...255, step: 1.0)
            Text("\(label): \(Int(value))")
        }
    }
}

#Preview {
    SliderView(value: Binding.constant(0), label: "Label").padding()
}

