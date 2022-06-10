//
//  BorderModifier.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.06.2022.
//

import SwiftUI

struct RoundedInnerBorder: ViewModifier {
    let color: Color
    let corners: UIRectCorner
    
    init(color: Color, corners: UIRectCorner = .allCorners) {
        self.color = color
        self.corners = corners
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedInnerCornerShape(radius: 12, corners: corners)
                    .strokeBorder(color, lineWidth: 2)
            )
    }
}

struct RoundedInnerCornerShape: InsettableShape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    var inset = 0.0

    func path(in rect: CGRect) -> Path {
        let rect = rect.insetBy(dx: inset, dy: inset)

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.inset += amount
        return shape
    }
}
