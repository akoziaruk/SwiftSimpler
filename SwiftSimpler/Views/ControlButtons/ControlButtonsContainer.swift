//
//  ControlButtonsContainer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI
import CryptoKit

struct ControlButtonsContainer: View {
    var body: some View {
        HStack(spacing: 40) {
            BMPConfigurationView()
            PlayButton()
            Spacer()
        }.background(.red)
    }
}

struct PlayButton: View {
    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        ZStack {
            if conductor.data.isPlaying {
                TriangleShape()
                    .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
                    .frame(width: 70, height: 65)
                    .rotationEffect(Angle(degrees: 90))
                    .padding()
            } else {
                PauseShape()
                    .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
                    .frame(width: 70, height: 65)
                    .padding()
            }
        }
        .onTapGesture {
            conductor.data.isPlaying = !conductor.data.isPlaying
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.yellow, lineWidth: 2)
            )
    }
}

struct PauseShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
//TODO: Implement
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        
        return path

    }
}
