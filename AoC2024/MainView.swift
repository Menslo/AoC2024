//
//  ContentView.swift
//  AoC2024
//
//  Created by Simon Zwicker on 01.12.24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(Day.allCases, id: \.self) { day in
                    NavigationLink(value: day) {
                        Text(day.title)
                    }
                }
            }
            .navigationTitle("Advent of Code 2024")
            .navigationDestination(for: Day.self) { day in
                day.view
            }
        }
    }
}

#Preview {
    MainView()
}
