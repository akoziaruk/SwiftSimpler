//
//  CGFloat+Extention.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

extension CGFloat {
    var radians: CGFloat {
        CGFloat(Angle(degrees: Double(self)).radians)
    }
}
