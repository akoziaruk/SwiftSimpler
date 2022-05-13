//
//  PadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct PadsView: View {
    @Binding var trackLockState: TrackLockState
    @ObservedObject var conductor: Conductor
    
    var body: some View {
        switch trackLockState {
        case .locked:
            SequencerPadsView(items: $conductor.data.sampleSequence)
        case .locking:
            SamplePadsView(padsCount: conductor.samples.count) {
                trackLockState = .locked
                conductor.activeTrackIndex = $0
            }
        case .none:
            SamplePadsView(padsCount: conductor.samples.count) {
                conductor.playPad(at: $0)
            }
        }
    }
}
