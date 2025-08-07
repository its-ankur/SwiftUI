import SwiftUI

struct SlotsScreen: View {
    
    @StateObject var slots = SlotsScreenModel()
    
    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .ignoresSafeArea()
            Rectangle()
                .foregroundColor(Color(red: 226/255, green: 195/255, blue: 76/255))
                .rotationEffect(.degrees(45))
                .ignoresSafeArea()
            
            VStack {
                // Header
                HStack {
                    CustomImage(name: "star.fill", isSystem: true, size: 50, color: .yellow)
                    CustomText(title: "SwiftUI Slots!",fontWeight: .bold, textColor: .white, padding: EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    CustomImage(name: "star.fill", isSystem: true, size: 50, color: .yellow)
                }
                
                Spacer()
                
                // Credit Display
                CustomText(title: "Credits: \(slots.credits)", textColor: .black, cornerRadius: 20, backGround: Color.white.opacity(0.5), padding: EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                
                CustomText(title: "Spins: \(slots.spinCount)", textColor: .black, padding: EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                Spacer()
                
                // Slot Rows
                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        Spacer()
                        ForEach(0..<3, id: \.self) { col in
                            SlotCard(symbol: $slots.symbols[slots.numbers[row][col]])
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                // Win Message
                if slots.showWin {
                    CustomText(title: slots.winMessage, font: .callout, fontWeight: .bold, textColor: .white, cornerRadius: 20, backGround: Color.green.opacity(0.8), padding: EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 20))
                        .transition(.scale)
                        .zIndex(1)
                    Spacer()
                }
                
//                switch slots.symbols[0] {
//                    case "apple":
//                        print("Apple")
//                default:
//                    print("None")
//                }
                
                
                // Spin Button
                Button(action: {
                    spinSlots()
                }) {
                    CustomText(title: "Spin", fontWeight: .bold, textColor: .white, cornerRadius: 20, backGround: slots.isButtonDisabled ? Color.gray : Color.pink, padding: EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                }
                .disabled(slots.isButtonDisabled)
                
                Spacer()
            }
        }
        .alert(isPresented: $slots.showGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("You've run out of credits after \(slots.spinCount) spins.\nWould you like to play again?"),
                primaryButton: .default(Text("Play Again"), action: resetGame),
                secondaryButton: .cancel(Text("Quit"), action: { exit(0)})
            )
        }
    }
    
    // MARK: - Game Logic
    
    private func spinSlots() {
        slots.spinCount += 1
        
        // Randomize all slots
        for row in 0..<3 {
            for col in 0..<3 {
                slots.numbers[row][col] = Int.random(in: 0..<slots.symbols.count)
            }
        }
        
        // Check matches
        var rewardMultiplier = 0
        var newWinMessage = ""
        
        // Horizontal matches (2x)
        for row in 0..<3 {
            if slots.numbers[row][0] == slots.numbers[row][1],
               slots.numbers[row][1] == slots.numbers[row][2] {
                rewardMultiplier += 2
                newWinMessage += "➡️ Row \(row + 1) match! +2x\n"
            }
        }
        
        // Vertical matches (2x)
        for col in 0..<3 {
            if slots.numbers[0][col] == slots.numbers[1][col],
               slots.numbers[1][col] == slots.numbers[2][col] {
                rewardMultiplier += 2
                newWinMessage += "⬇️ Column \(col + 1) match! +2x\n"
            }
        }
        
        // Diagonal matches (5x)
        if slots.numbers[0][0] == slots.numbers[1][1],
           slots.numbers[1][1] == slots.numbers[2][2] {
            rewardMultiplier += 5
            newWinMessage += "↘️ Diagonal match! +5x\n"
        }
        if slots.numbers[0][2] == slots.numbers[1][1],
           slots.numbers[1][1] == slots.numbers[2][0] {
            rewardMultiplier += 5
            newWinMessage += "↙️ Diagonal match! +5x\n"
        }
        
        // Jackpot (all same symbol) — override reward
        if Set(slots.numbers.flatMap { $0 }).count == 1 {
            rewardMultiplier = 1000
            newWinMessage = "🎰 JACKPOT! All Match +10x"
        }
        
        // Apply result
        if rewardMultiplier > 0 {
            slots.credits += slots.bet * rewardMultiplier
            slots.winMessage = newWinMessage
            withAnimation {
                slots.showWin = true
                slots.isButtonDisabled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    slots.showWin = false
                    slots.isButtonDisabled = false
                }
            }
        } else {
            slots.credits -= slots.deduct
        }
        
        if slots.credits <= 0 {
            slots.isButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                slots.showGameOver = true
            }
        }
    }
    
    private func resetGame() {
        slots.credits = 1000
        slots.spinCount = 0
        slots.numbers = Array(repeating: Array(repeating: 0, count: 3), count: 3)
        slots.showWin = false
        slots.winMessage = ""
        slots.isButtonDisabled = false
    }
    
}

#Preview {
    SlotsScreen()
}

