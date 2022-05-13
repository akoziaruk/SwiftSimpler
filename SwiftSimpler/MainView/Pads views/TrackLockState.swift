//
//  TrackLockState.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation

enum TrackLockState: Equatable {
    case none
    case locking
    case locked
    
    mutating func toggleTap() {
        if self == .none {
            self = .locking
        } else {
            self = .none
        }
    }
}
