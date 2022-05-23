//
//  ControlButtonsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct ControlButtonsView: View {
    @Binding var isPlaying: Bool
    @Binding var trackLockState: TrackLockState

    var body: some View {
        HStack {
            Button(isPlaying ? "STOP" : "PLAY") {
                isPlaying.toggle()
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(.purple)
            .foregroundColor(.white)
            .padding()

            Spacer()
            
            Button("TRACK") {
                trackLockState.toggleTap()
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(trackLockState == .none ? .yellow: .yellow.opacity(0.5))
            .foregroundColor(.white)
            .background(trackLockState == .locking ? .red: .clear)
            .padding()
        }
    }
}
