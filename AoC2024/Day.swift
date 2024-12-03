//
//  Day.swift
//  AoC2024
//
//  Created by Simon Zwicker on 01.12.24.
//

import SwiftUI

enum Day: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

extension Day {
    var title: String {
        "Türchen \(self.rawValue)"
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .one: DoorOne()
        case .two: DoorTwo()
        case .three: DoorThree()
        default: EmptyView()
        }
    }
}
