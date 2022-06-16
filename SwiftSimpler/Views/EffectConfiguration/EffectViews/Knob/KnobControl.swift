//
//  KnobControl.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobControl: View {
    @Binding var value: Value
    @State var lastTranslation: CGFloat = 0

    var range: ClosedRange<Value>
    
    var currentAngle: CGFloat {
        let travelLengthAngle = 360 - Constants.startAngle + Constants.endAngle
        let progress = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        let angle = progress * Float(travelLengthAngle)
        return CGFloat(Constants.startAngle + CGFloat(angle))
    }
    
    var body: some View {
            ZStack {
                GeometryReader { context in
                    Circle()
                        .foregroundColor(Palette.white)
                    
                    KnobControlPointerShape(offsetProportion: Constants.offsetProportion, angle: currentAngle.radians)
                        .stroke(Palette.black, style: StrokeStyle(lineWidth: 4, lineCap: .round))

                    KnobControlEdgesShape(offsetProportion: Constants.offsetProportion,
                                          startAngle: Constants.startAngle.radians,
                                          endAngle: Constants.endAngle.radians)
                        .stroke(Palette.blackLight, lineWidth: 1)

                    Text(String(format: "%.1f", value))
                        .foregroundColor(Palette.black)
                        .font(.footnote)
                        .frame(width: context.size.width, height: context.size.height * (1 - Constants.offsetProportion))
                        .padding(.top, context.size.height * Constants.offsetProportion)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ gesture in
                        
                        let translation = gesture.translation.width + -gesture.translation.height
                        let travelLength = CGFloat(range.upperBound - range.lowerBound)
                        let step = (translation - lastTranslation) * (travelLength / 100.0)
                                            
                        value = Float(max(min(value + Float(step), range.upperBound), range.lowerBound))
                        lastTranslation = translation
                    })
                    .onEnded({ gesture in
                        lastTranslation = 0
                    })
            )
    }
    
    struct Constants  {
        static let offsetProportion = 0.6
        static let startAngle = 140.0 as CGFloat
        static let endAngle = 40.0 as CGFloat
    }
}
