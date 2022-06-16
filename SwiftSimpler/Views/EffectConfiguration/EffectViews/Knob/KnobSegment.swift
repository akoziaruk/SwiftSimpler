//
//  KnobSegment.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 15.06.2022.
//

import SwiftUI

struct KnobSegment: View {
    let title: String
    @State var value: CGFloat = 50
    
    var body: some View {
        GeometryReader { context in
            VStack(spacing: 18) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Palette.white)
                
                KnobControl(value: $value)
                    .frame(height: context.size.width)
            }
        }
    }
}
