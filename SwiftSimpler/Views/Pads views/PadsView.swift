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
    @Binding var selectedTrack: Int
    
    var body: some View {
        switch trackLockState {
        case .locked:
            SequencerPadsView(sequence: $conductor.sequences[selectedTrack],
                              page: conductor.data.playback.page)
        case .locking:
            SamplePadsView(padsCount: conductor.samples.count) {
                trackLockState = .locked
                selectedTrack = $0
            }
        case .none:
            SamplePadsView(padsCount: conductor.samples.count) {
                conductor.samples[$0].play()
            }
        }
    }
}
