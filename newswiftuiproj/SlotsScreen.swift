import SwiftUI

struct SlotsScreen: View {
    
    @State private var symbols = ["apple", "star", "cherry", "mango"]
    //@State private var symbols = ["apple"]
    @State private var numbers = Array(repeating: Array(repeating: 0, count: 3), count: 3)
    @State private var credits = 1000
    @State private var showWin = false
    @State private var winMessage = ""
    @State private var isButtonDisabled = false
    @State private var spinCount = 0
    @State private var showGameOver = false
    
    private var bet = 5
    private var deduct = 25
    
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
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(.yellow)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                    Text("SwiftUI Slots!")
                        .foregroundColor(.white)
                        .bold()
                        .font(.largeTitle)
                        .padding(.horizontal)
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundColor(.yellow)
                        .frame(width: 50, height: 50)
                }
                
                Spacer()
                
                // Credit Display
                Text("Credits: \(credits)")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Text("Spins: \(spinCount)")
                    .foregroundColor(.black)
                    .padding(.bottom, 10)
                
                Spacer()
                
                // Slot Rows
                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        Spacer()
                        ForEach(0..<3, id: \.self) { col in
                            SlotCard(symbol: $symbols[numbers[row][col]])
                        }
                        Spacer()
                    }
                }
                
                Spacer()
                
                // Win Message
                if showWin {
                    Text(winMessage)
                        .font(.callout)
                        .bold()
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .cornerRadius(20)
                        .foregroundColor(.white)
                        .transition(.scale)
                        .zIndex(1)
                    Spacer()
                }
                
                
                // Spin Button
                Button(action: {
                    spinSlots()
                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 30)
                        .background(isButtonDisabled ? Color.gray : Color.pink)
                        .cornerRadius(20)
                }
                .disabled(isButtonDisabled)
                
                Spacer()
            }
        }
        .alert(isPresented: $showGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("You've run out of credits after \(spinCount) spins.\nWould you like to play again?"),
                primaryButton: .default(Text("Play Again"), action: resetGame),
                secondaryButton: .cancel(Text("Quit"), action: { exit(0)})
            )
        }
    }
    
    // MARK: - Game Logic
    
    private func spinSlots() {
        spinCount += 1
        
        // Randomize all slots
        for row in 0..<3 {
            for col in 0..<3 {
                numbers[row][col] = Int.random(in: 0..<symbols.count)
            }
        }
        
        // Check matches
        var rewardMultiplier = 0
        var newWinMessage = ""
        
        // Horizontal matches (2x)
        for row in 0..<3 {
            if numbers[row][0] == numbers[row][1],
               numbers[row][1] == numbers[row][2] {
                rewardMultiplier += 2
                newWinMessage += "➡️ Row \(row + 1) match! +2x\n"
            }
        }
        
        // Vertical matches (2x)
        for col in 0..<3 {
            if numbers[0][col] == numbers[1][col],
               numbers[1][col] == numbers[2][col] {
                rewardMultiplier += 2
                newWinMessage += "⬇️ Column \(col + 1) match! +2x\n"
            }
        }
        
        // Diagonal matches (5x)
        if numbers[0][0] == numbers[1][1],
           numbers[1][1] == numbers[2][2] {
            rewardMultiplier += 5
            newWinMessage += "↘️ Diagonal match! +5x\n"
        }
        if numbers[0][2] == numbers[1][1],
           numbers[1][1] == numbers[2][0] {
            rewardMultiplier += 5
            newWinMessage += "↙️ Diagonal match! +5x\n"
        }
        
        // Jackpot (all same symbol) — override reward
        if Set(numbers.flatMap { $0 }).count == 1 {
            rewardMultiplier = 1000
            newWinMessage = "🎰 JACKPOT! All Match +10x"
        }
        
        // Apply result
        if rewardMultiplier > 0 {
            credits += bet * rewardMultiplier
            winMessage = newWinMessage
            withAnimation {
                showWin = true
                isButtonDisabled = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showWin = false
                    isButtonDisabled = false
                }
            }
        } else {
            credits -= deduct
        }
        
        if credits <= 0 {
            isButtonDisabled = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                showGameOver = true
            }
        }
    }
    
    private func resetGame() {
        credits = 1000
        spinCount = 0
        numbers = Array(repeating: Array(repeating: 0, count: 3), count: 3)
        showWin = false
        winMessage = ""
        isButtonDisabled = false
    }
    
}

#Preview {
    SlotsScreen()
}

