//
//  EffectPickerBorder.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.06.2022.
//

import SwiftUI

struct EffectPickerRoundedBottomBorder: Shape {
    var radius: CGFloat = 12
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0.0, y: 0.0))

        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - radius))

        path.addArc(withCenter: CGPoint(x: rect.minX + radius, y: rect.maxY - radius),
                    radius: radius,
                    startAngle: CGFloat(Double.pi),
                    endAngle: CGFloat(Double.pi / 2),
                    clockwise: false)

        path.addArc(withCenter: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius),
                    radius: radius,
                    startAngle: CGFloat(Double.pi / 2),
                    endAngle: 0,
                    clockwise: false)

        path.addLine(to: CGPoint(x: rect.maxX, y: 0))

        return Path(path.cgPath)
    }
}
