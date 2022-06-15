//
//  KnobControl.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobControl: View {
    @Binding var position: CGFloat // 0...100
    
    let offsetProportion = 0.6
    let startAngle = 140.0 as CGFloat
    let endAngle = 40.0 as CGFloat
        
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Palette.white)
            
            KnobControlEdgesShape(offsetProportion: offsetProportion,
                                  startAngle: startAngle.radians,
                                  endAngle: endAngle.radians)
                .stroke(Palette.blackLight, lineWidth: 1)

            KnobControlPointerShape(offsetProportion: offsetProportion, angle: currentAngle.radians)
                .stroke(Palette.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))
            
        }
    }
    
    var currentAngle: CGFloat {
        let totalLength = 360 - startAngle + endAngle
        let angle = position / 100.0 * totalLength
        return CGFloat(startAngle + angle)
    }
}
