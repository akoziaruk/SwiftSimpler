//
//  PadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct PadsContainerView: View {
    @EnvironmentObject var conductor: Conductor
    
    @Binding var activeTrack: Int
    @Binding var padsViewState: PadsViewState
    @Binding var trackSelectionActive: Bool

    var body: some View {

        switch padsViewState {
            
        case .sample:
            SamplePadsView(activeItemIndex: activeTrack) { index in
                if trackSelectionActive {
                    activeTrack = index
                    trackSelectionActive = false
                } else {
                    conductor.samples[index].play()
                }
            }

        case .sequencer:
            SequencerPadsView(sequence: $conductor.sequenceData[activeTrack],
                              playbackData: conductor.playbackData)
            
        }

    }
}
