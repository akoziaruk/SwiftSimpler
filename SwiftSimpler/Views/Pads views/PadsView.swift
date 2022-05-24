//
//  PadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct PadsView: View {
    @EnvironmentObject var conductor: Conductor
    @Binding var trackLockState: TrackLockState
    
    var body: some View {
        switch trackLockState {
        case .locked:
            SequencerPadsView(sequence: $conductor.sequences[conductor.selectedTrack])
        case .locking:
            SamplePadsView(padsCount: conductor.sampleCount) {
                trackLockState = .locked
                conductor.selectedTrack = $0
            }
        case .none:
            SamplePadsView(padsCount: conductor.sampleCount) {
                conductor.playPad(at: $0)
            }
        }
    }
}
