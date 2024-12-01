//
//  Day.swift
//  AoC2024
//
//  Created by Simon Zwicker on 01.12.24.
//

import SwiftUI

enum Day: Int, CaseIterable {
    case one = 1
}

extension Day {
    var title: String {
        "Türchen \(self.rawValue)"
    }
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .one: DoorOne()
        default: EmptyView()
        }
    }
}
