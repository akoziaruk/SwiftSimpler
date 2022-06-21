//
//  PlayButton.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct PlayButton: View {
    @Binding var isPlaying: Bool
    
    var body: some View {
        ZStack {
            if isPlaying {
                PauseShape()
                    .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 6, lineJoin: .round))
//                    .frame(width: 70, height: 65)
                    .padding()
            } else {
                TriangleShape()
                    .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
//                    .frame(width: 70, height: 65)
                    .rotationEffect(Angle(degrees: 90))
                    .padding()
            }
        }
        .onTapGesture {
            isPlaying = !isPlaying
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.yellow, lineWidth: 2)
            )
    }
}

