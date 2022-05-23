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
    @Binding var selectedIndex: Int
    
    var body: some View {
        switch trackLockState {
        case .locked:
            SequencerPadsView(items: $conductor.data[selectedIndex].sequence)
        case .locking:
            SamplePadsView(padsCount: conductor.sampleCount) {
                trackLockState = .locked
                selectedIndex = $0
            }
        case .none:
            SamplePadsView(padsCount: conductor.sampleCount) {
                conductor.playPad(at: $0)
            }
        }
    }
}
