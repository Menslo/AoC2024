import SwiftUI

struct DoorThree: View {
    
    // Daten
    @State private var memory: String = ""
    @State private var multiplicationSum: Int = 0
    
    var body: some View {
        VStack {
            Button("Calculate Multiplication Sum") {
                calculateMultiplicationSum()
            }
            .font(.title)
            .foregroundStyle(.blue.gradient)
            
            if multiplicationSum > 0 {
                Text("Multiplication Sum: \(multiplicationSum)")
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
                    .foregroundStyle(.green.gradient)
            }
        }
        .onAppear {
            onAppear()
        }
    }
    
    // Daten beim Erscheinen laden
    private func onAppear() {
        do {
            let inputArray = try Loader.readInput(from: "InputThree")
            memory = inputArray.joined(separator: " ") // Alles in einen String umwandeln
        } catch {
            print("Error loading file: \(error.localizedDescription)")
        }
    }
    
    // Berechnet die Summe aller gültigen Multiplikationen
    private func calculateMultiplicationSum() {
        print("Starting multiplication sum calculation...") // Debugging
        
        let regex = try! NSRegularExpression(pattern: #"mul\((\d+),(\d+)\)"#)
        let range = NSRange(memory.startIndex..<memory.endIndex, in: memory)
        let matches = regex.matches(in: memory, options: [], range: range)
        
        var sum = 0
        
        for match in matches {
            if let xRange = Range(match.range(at: 1), in: memory),
               let yRange = Range(match.range(at: 2), in: memory) {
                let x = Int(memory[xRange]) ?? 0
                let y = Int(memory[yRange]) ?? 0
                let result = x * y
                print("Found: mul(\(x),\(y)) = \(result)") // Debugging
                sum += result
            }
        }
        
        print("Total Multiplication Sum: \(sum)") // Debugging
        
        withAnimation {
            self.multiplicationSum = sum
        }
    }
}
