//
//  KnobSegment.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobSegment: View {
    let title: String

    @Binding var parameter: Parameter

    var body: some View {
        GeometryReader { context in
            
            VStack(spacing: 18) {
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(Palette.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(height: 24)
                
                    let side = context.size.width - Constants.padding*2
                    KnobControl(value: $parameter.value, range: parameter.range)
                        .frame(width: side, height: side)
                        .padding([.trailing, .leading], Constants.padding)
            }
        }
        
    }
    
    struct Constants {
        static let padding = 5 as CGFloat
    }
}
