//
//  PlaybackView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import SwiftUI

struct PlaybackView: View {
    @EnvironmentObject var conductor: Conductor

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(.gray.opacity(0.3))
                
                PlaybackCursor(width: geometry.size.width / 16)
            }
            .padding()
        }
    }
}

struct PlaybackCursor: View {
    @EnvironmentObject var conductor: Conductor
    @State var position = 0

    var width: CGFloat
    let timer = Timer.publish(every: 1/30, on: .main, in: .common).autoconnect()

    var body: some View {
        Rectangle()
            .frame(width: width, height: 10)
            .foregroundColor(.brown)
            .offset(x: width*CGFloat(position), y: 0)
            .onReceive(timer) { _ in
                position = conductor.position
            }
    }
}
