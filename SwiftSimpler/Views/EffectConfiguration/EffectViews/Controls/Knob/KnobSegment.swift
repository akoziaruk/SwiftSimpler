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
                    .minimumScaleFactor(0.8)
                
                KnobControl(value: $parameter.value, range: parameter.range)
                    .frame(height: context.size.width)
                
            }
        }
        
    }
}
