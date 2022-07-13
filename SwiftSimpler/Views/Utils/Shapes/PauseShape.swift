//
//  PauseShape.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct PauseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let padding = rect.maxX / 4
        path.move(to: CGPoint(x: rect.midX - padding , y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - padding, y: rect.maxY))
        
        path.move(to: CGPoint(x: rect.midX + padding , y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + padding, y: rect.maxY))

        return path
    }
}
