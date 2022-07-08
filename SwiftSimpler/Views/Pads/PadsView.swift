//
//  PadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct PadsContainerView: View {
    @EnvironmentObject var conductor: Conductor
    
    @Binding var selectedTrack: Int
    @Binding var padsViewState: PadsViewState
    @Binding var trackSelectionActive: Bool

    var body: some View {

        switch padsViewState {
            
        case .sample:
            SamplePadsView() { index in
                if trackSelectionActive {
                    selectedTrack = index
                } else {
                    conductor.samples[index].play()
                }
            }

        case .sequencer:
            SequencerPadsView()
            
        }

    }
}
