import SwiftUI

struct DoorTwo: View {
    
    // Daten
    @State private var leftList: [Int] = []
    @State private var rightList: [Int] = []
    @State private var similarityScore: Int = 0
    
    var body: some View {
        VStack {
            Button("Calculate Similarity Score") {
                calculateSimilarityScore()
            }
            .font(.title)
            .foregroundStyle(.blue.gradient)
            
            if similarityScore > 0 {
                Text("Similarity Score: \(similarityScore)")
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
            let inputArray = try Loader.readInput(from: "InputTwo") // Datei: InputTwo.txt
            parseLists(inputArray)
        } catch {
            print("Error loading file: \(error.localizedDescription)")
        }
    }
    
    // Listen aus der Eingabedatei parsen
    private func parseLists(_ plain: [String]) {
        for line in plain {
            let numbers = line
                .split(separator: " ")
                .compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
            
            if numbers.count == 2 { // Erwartet je eine Zahl in der linken und rechten Liste
                leftList.append(numbers[0])
                rightList.append(numbers[1])
            }
        }
        print("Left List: \(leftList)")  // Debugging
        print("Right List: \(rightList)") // Debugging
    }
    
    // Ähnlichkeitspunktzahl berechnen
    private func calculateSimilarityScore() {
        print("Starting similarity score calculation...") // Debugging
        
        // Häufigkeiten der rechten Liste berechnen
        var rightListFrequency: [Int: Int] = [:]
        for number in rightList {
            rightListFrequency[number, default: 0] += 1
        }
        
        print("Right List Frequency: \(rightListFrequency)") // Debugging
        
        var score = 0
        
        // Punktzahl berechnen
        for number in leftList {
            if let count = rightListFrequency[number] {
                score += number * count
                print("Adding \(number) * \(count) = \(number * count)") // Debugging
            }
        }
        
        print("Total Similarity Score: \(score)") // Debugging
        
        withAnimation {
            self.similarityScore = score
        }
    }
}
