//
//  PlayButton.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct PlayButton: View {
    @EnvironmentObject var conductor: Conductor
    
    var body: some View {
        ZStack {
            if !conductor.data.isPlaying {
                TriangleShape()
                    .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
                    .frame(width: 70, height: 65)
                    .rotationEffect(Angle(degrees: 90))
                    .padding()
            } else {
                PauseShape()
                    .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 6, lineJoin: .round))
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

