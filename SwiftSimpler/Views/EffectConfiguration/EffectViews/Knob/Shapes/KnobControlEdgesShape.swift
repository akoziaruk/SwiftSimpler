//
//  KnobControlEdgesShape.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobControlEdgesShape: Shape {
    let offsetProportion: CGFloat
    let startAngle: CGFloat
    let endAngle: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.midX

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * offsetProportion))
        path.addLine(to: CGPoint(x: rect.midX + radius * cos(startAngle),
                                 y: rect.midY + radius * sin(startAngle)))

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * offsetProportion))
        path.addLine(to: CGPoint(x: rect.midX + radius * cos(endAngle),
                                 y: rect.midY + radius * sin(endAngle)))
        
        return path
    }
}
