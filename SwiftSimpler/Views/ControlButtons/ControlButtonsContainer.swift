//
//  ControlButtonsContainer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI
import CryptoKit

struct ControlButtonsContainer: View {
    @EnvironmentObject var conductor: Conductor
    @Binding var state: PadsViewState
    @Binding var trackSelectionActive: Bool
    
    var body: some View {
        GeometryReader { context in
            HStack(spacing: 40) {
                BMPConfigurationView(tempo: $conductor.playbackData.tempo)
                
                PlayButton(isPlaying: $conductor.playbackData.isPlaying)
                    .frame(width: context.size.height)
                
                Spacer()
                
                ControlButton(text: state == .sample ? "SEQ": "SMP") {
                    state.toggle()
                }
                    .frame(width: context.size.height)

                TrackButton(active: trackSelectionActive) {
                    if trackSelectionActive {
                        trackSelectionActive = false
                    } else {
                        trackSelectionActive = true
                        state = .sample
                    }
                }
                    .frame(width: context.size.height)
            }
        }
    }
}
