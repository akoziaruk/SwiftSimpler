//
//  TrackLockState.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.05.2022.
//

import Foundation

enum TrackLockState: Equatable {
    case none
    case locking
    case locked(track: Int)
    
    func notLocked() -> Bool {
        self == .none || self == .locking
    }
    
    mutating func toggle() {
        if self == .none {
            self = .locking
        } else {
            self = .none
        }
    }
}
