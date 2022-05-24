//
//  MainView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 19.05.2022.
//

import SwiftUI
import AudioKit

struct MainView: View {
    @EnvironmentObject var conductor: Conductor
    @State var trackLockState = TrackLockState.none
    
    var body: some View {
        VStack {
            EffectConfigurationView(effect: $conductor.effectsConfigurations[conductor.selectedTrack])
            ControlsView(isPlaying: $conductor.isPlaying, tempo: $conductor.tempo, trackLockState: $trackLockState)
            PadsView(trackLockState: $trackLockState)
            PlaybackView(position: $conductor.playbackPosition, segments: conductor.gridLength)
        }.onAppear {
            conductor.start()
        }.onDisappear {
            conductor.stop()
        }
    }
}
