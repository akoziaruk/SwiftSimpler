//
//  PadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct PadsView_OLD: View {
    @EnvironmentObject var conductor: Conductor
    @Binding var trackLockState: TrackLockState
    @Binding var selectedTrack: Int
    
    var body: some View {
        switch trackLockState {
        case .locked:
            SamplePadsView_OLD(padsCount: conductor.samples.count) {
                conductor.samples[$0].play()
            }
            case .locking:
            SamplePadsView_OLD(padsCount: conductor.samples.count) {
                trackLockState = .locked
                selectedTrack = $0
            }
        case .none:
            SamplePadsView_OLD(padsCount: conductor.samples.count) {
                conductor.samples[$0].play()
            }
        }
    }
}
