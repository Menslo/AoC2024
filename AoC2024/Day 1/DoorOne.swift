//
//  DoorOne.swift
//  AoC2024
//
//  Created by Simon Zwicker on 01.12.24.
//

import SwiftUI

struct DoorOne: View {
    
    //Part 1
    @State private var dataOne: [Int] = []
    @State private var dataTwo: [Int] = []
    @State private var firstAnswer: Int = 0
    @State private var secondAnswer: Int = 0
    
    var body: some View {
        VStack {
            Button("First Answer") {
                calcFirstAnswer()
            }
            .font(.title)
            .foregroundStyle(.blue.gradient)
            
            if firstAnswer > 0 {
                Text(firstAnswer, format: .number)
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
                    .foregroundStyle(.green.gradient)
                
                Button("Second Answer") {
                    calcSecondAnswer()
                }
                .font(.title)
                .foregroundStyle(.blue.gradient)
            }
            
            if secondAnswer > 0 {
                Text(secondAnswer, format: .number)
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
                    .foregroundStyle(.green.gradient)
            }
        }
        .onAppear {
            onAppear()
        }
    }
    
    private func onAppear() {
        do {
            let inputArray = try Loader.readInput(from: "InputOne")
            getData(inputArray)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func getData(_ plain: [String]) {
        for line in plain {
            let split = line.split(separator: " ")
            
            if let first = split.first?.trimmingCharacters(in: .whitespacesAndNewlines), let firstRaw = Int(first),
                let second = split.last?.trimmingCharacters(in: .whitespacesAndNewlines), let secondRaw = Int(second) {
                dataOne.append(Int(firstRaw))
                dataTwo.append(Int(secondRaw))
            }
        }
        
        dataOne.sort()
        dataTwo.sort()
    }
    
    private func calcFirstAnswer() {
        var result = 0
        
        for i in 0..<dataOne.count {
            result += abs(dataOne[i] - dataTwo[i])
        }
        
        withAnimation {
            self.firstAnswer = result
        }
    }
    
    func calcSecondAnswer() {
        // Create a frequency dictionary for the right list
        var dataTwoRepeat: [Int: Int] = [:]
        
        for number in dataTwo {
            dataTwoRepeat[number, default: 0] += 1
        }
        
        // Calculate the similarity score
        var result = 0
        
        for number in dataOne {
            if let countInDataTwo = dataTwoRepeat[number] {
                result += number * countInDataTwo
            }
        }
        
        withAnimation {
            self.secondAnswer = result
        }
    }
}
