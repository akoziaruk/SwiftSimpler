//
//  BMPConfiguration.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct BMPConfigurationView: View {
    @Binding var tempo: Int
    
    var body: some View {
        HStack(spacing: 15) {
            VStack {
                Text("\(tempo)")
                    .font(.system(size: 44))
                    .fontWeight(.semibold)
                    .foregroundColor(Palette.yellow)
                    .frame(width: 80)

                Text("BPM")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(Palette.yellow)
            }
            .padding(.leading, 15)
            
            // Triangle buttons
            VStack {
                BPMTriangleButton {
                    tempo += 1
                }
                    
                BPMTriangleButton {
                    tempo -= 1
                }
                .rotationEffect(Angle(degrees: 180))
            }
            .padding([.trailing, .top, .bottom], 15)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.yellow, lineWidth: 2)
        )
    }
}
