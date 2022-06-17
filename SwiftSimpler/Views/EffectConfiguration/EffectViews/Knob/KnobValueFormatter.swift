//
//  KnobValueFormatter.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 17.06.2022.
//

import Foundation

extension Value {
    var displayFormatted: String {
        if (self < 10) {
            return String(format: "%.1f", self)
        } else {
            return "\(Int(self))"
        }
    }
}
