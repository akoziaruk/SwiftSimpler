//
//  KnobControl.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobControl: View {
    @Binding var value: CGFloat // 0...100
    @State var lastTranslation: CGFloat = 0

    var currentAngle: CGFloat {
        let totalLength = 360 - Constants.startAngle + Constants.endAngle
        let angle = value / 100.0 * totalLength
        return CGFloat(Constants.startAngle + angle)
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

                    Text("\(Int(value))")
                        .foregroundColor(Palette.black)
                        .font(.footnote)
                        .frame(width: context.size.width, height: context.size.height * (1 - Constants.offsetProportion))
                        .padding(.top, context.size.height * Constants.offsetProportion)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ gesture in
                        let translation = -gesture.translation.height
                        value = max(min(value + translation - lastTranslation, 100), 0)
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
