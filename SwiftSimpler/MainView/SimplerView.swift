//
//  SimplerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct EffectsView: View {
    @Binding var data: SimplerData
    var body: some View {
        VStack {
            EffectView(title: "Distortion", parameter: $data.effects.distortion)
            EffectView(title: "Reverb", parameter: $data.effects.reverb)
            EffectView(title: "Delay", parameter: $data.effects.delay)
        }
    }
}

struct EffectView: View {
    let title: String
    @Binding var parameter: Float

    var body: some View {
        HStack {
            Text(title)
            Slider(value: $parameter, in: 0...100)
        }
    }
}

struct SimplerView: View {
    @StateObject var conductor = Conductor()
    @State var trackLockState = TrackLockState.none
    
    var body: some View {
        VStack {
            HStack {
                TitleView()
                EffectsView(data: $conductor.data)
            }
            
            ControlButtonsView(isPlaying: $conductor.data.isPlaying, trackLockState: $trackLockState)
            
            switch trackLockState {
            case .locked:
                SequencerView(items: $conductor.data.sampleSequence)
            case .locking:
                PadsView(padsCount: conductor.samples.count) {
                    trackLockState = .locked
                    conductor.activeTrackIndex = $0
                }
            case .none:
                PadsView(padsCount: conductor.samples.count) {
                    conductor.playPad(at: $0)
                }
            }
            
            PlaybackView(position: $conductor.playbackPosition,
                         segments: conductor.sequencer.gridLength)
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

