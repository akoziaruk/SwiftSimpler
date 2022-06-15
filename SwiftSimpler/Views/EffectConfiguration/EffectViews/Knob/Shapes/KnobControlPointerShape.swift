//
//  KnobControlShape.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobControlPointerShape: Shape {
    let offsetProportion: CGFloat
    let angle: CGFloat
    let padding = 3.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.midX - padding

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * offsetProportion))
        path.addLine(to: CGPoint(x: rect.midX + radius * cos(angle),
                                 y: rect.midY + radius * sin(angle)))
        
        return path
    }
}
