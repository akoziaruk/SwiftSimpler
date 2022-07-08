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
                BMPConfigurationView(tempo: $conductor.data.tempo)
                
                PlayButton(isPlaying: $conductor.data.isPlaying)
                    .frame(width: context.size.height)
                
                Spacer()
                
                ControlButton(text: state == .sample ? "SEQ": "SMP") {
                    state.toggle()
                }
                    .frame(width: context.size.height)

                TrackButton(active: $trackSelectionActive)
                    .frame(width: context.size.height)
            }
        }
    }
}
