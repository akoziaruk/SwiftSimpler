//
//  HalfOpenRoundedRect.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.06.2022.
//

import SwiftUI

struct OpenEdgeRoundedRect: InsettableShape {
    var radius: CGFloat = 12
    var inset: CGFloat = 0.0
    var openEdge: Edge
    
    func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: inset, dy: inset)

        switch openEdge {
        case .top:
            return rect.topOpenPath(with: radius)
            
        case .leading:
            return rect.leadingOpenPath(with: radius)
            
        case .bottom:
            return rect.bottomOpenPath(with: radius)
            
        case .trailing:
            return rect.trailingOpenPath(with: radius)
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.inset += amount
        return shape
    }
}

fileprivate extension CGRect {
    func topOpenPath(with radius: CGFloat) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: minX, y: minY))

        path.addLine(to: CGPoint(x: minX, y: maxY - radius))
        
        path.addArc(center: CGPoint(x: minX + radius, y: maxY - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 180),
                    endAngle:  Angle(degrees: 90),
                    clockwise: true)

        path.addArc(center: CGPoint(x: maxX - radius, y: maxY - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 90),
                    endAngle: Angle(degrees: 0),
                    clockwise: true)

        path.addLine(to: CGPoint(x: maxX, y: 0))
        
        return path
    }
    
    func trailingOpenPath(with radius: CGFloat) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: maxX, y: minY))

        path.addLine(to: CGPoint(x: minX + radius, y: minY))
        
        path.addArc(center: CGPoint(x: minX + radius, y: minY + radius),
                    radius: radius,
                    startAngle: Angle(degrees: -90),
                    endAngle:  Angle(degrees: 180),
                    clockwise: true)

        path.addArc(center: CGPoint(x: minX + radius, y: maxY - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 180),
                    endAngle: Angle(degrees: 90),
                    clockwise: true)

        path.addLine(to: CGPoint(x: maxX, y: maxY))
        
        return path
    }

    func bottomOpenPath(with radius: CGFloat) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: minX, y: maxY))

        path.addLine(to: CGPoint(x: minX, y: minY + radius))
        
        path.addArc(center: CGPoint(x: minX + radius, y: minY + radius),
                    radius: radius,
                    startAngle: Angle(degrees: 180),
                    endAngle:  Angle(degrees: -90),
                    clockwise: false)

        path.addArc(center: CGPoint(x: maxX - radius, y: minY + radius),
                    radius: radius,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: 0),
                    clockwise: false)

        path.addLine(to: CGPoint(x: maxX, y: maxY))
        
        return path
    }
    
    func leadingOpenPath(with radius: CGFloat) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: minX, y: minY))

        path.addLine(to: CGPoint(x: maxX - radius, y: minY))
        
        path.addArc(center: CGPoint(x: maxX - radius, y: minY + radius),
                    radius: radius,
                    startAngle: Angle(degrees: -90),
                    endAngle:  Angle(degrees: 0),
                    clockwise: false)

        path.addArc(center: CGPoint(x: maxX - radius, y: maxY - radius),
                    radius: radius,
                    startAngle: Angle(degrees: 0),
                    endAngle: Angle(degrees: 90),
                    clockwise: false)

        path.addLine(to: CGPoint(x: minX, y: maxY))
        
        return path
    }
    
}
