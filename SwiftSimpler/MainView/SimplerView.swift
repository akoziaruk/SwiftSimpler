//
//  SimplerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct SimplerView: View {
    @StateObject var conductor = Conductor()
    @State var trackLockState = TrackLockState.none
    @State var activeEffect = Effect.distortion
    
    var body: some View {
        VStack {
            EffectConfigurationView(activeEffect: $activeEffect, data: $conductor.data)
            EffectPickerView(selectedEffect: $activeEffect)
            ControlButtonsView(isPlaying: $conductor.data.isPlaying, trackLockState: $trackLockState)
            PadsView(trackLockState: $trackLockState, conductor: conductor)
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

