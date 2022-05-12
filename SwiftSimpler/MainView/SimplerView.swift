//
//  SimplerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct SimplerView: View {
    @StateObject var conductor = SequencerConductor()
    @State var trackLockState = TrackLockState.none
    
    var body: some View {
        VStack {
            TitleView()
            ControlButtonsView(isPlaying: $conductor.isPlaying, trackLockState: $trackLockState)
            
            switch trackLockState {
            case .locked:
                SequencerView(items: $conductor.lockedSampleSequence) {
                    conductor.updateActiveTrackSequence(at: $0)
                }
            case .locking:
                PadsView(padsCount: conductor.sampleCount) {
                    trackLockState = .locked
                    conductor.activeTrackIndex = $0
                }
            case .none:
                PadsView(padsCount: conductor.sampleCount) {
                    conductor.playPad(at: $0)
                }
            }
            
            PlaybackView(position: $conductor.playbackPosition, segments: conductor.sequencer.gridLength)
        }
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct SimplerView_Previews: PreviewProvider {
    static var previews: some View {
        SimplerView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

