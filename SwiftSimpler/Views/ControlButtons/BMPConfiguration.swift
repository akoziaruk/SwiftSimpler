//
//  BMPConfiguration.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct BMPConfigurationView: View {
    @EnvironmentObject var conductor: Conductor
        
    var body: some View {
        HStack(spacing: 15) {
            VStack {
                Text("\(Int(conductor.data.tempo))")
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
                BPMButton {
                    conductor.data.tempo += 1
                }
                    
                BPMButton {
                    conductor.data.tempo -= 1
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

struct BPMButton: View {
    let action: ()->()

    var body: some View {
        TriangleShape()
            .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
            .frame(width: 40, height: 30)
            .onTapGesture {
                action()
            }
    }
}
