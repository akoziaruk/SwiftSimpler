//
//  PadsViewState.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import Foundation

enum PadsViewState {
    case sequencer
    case sample
}

extension PadsViewState {
    mutating func toggle() {
        switch self {
        case .sequencer:
            self = .sample
        case .sample:
            self = .sequencer
        }
    }
}
