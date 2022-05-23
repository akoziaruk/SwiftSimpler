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
    
    @State var selectedIndex = 0
    @State var trackLockState = TrackLockState.none
    
    var body: some View {
        VStack {
            EffectViewWrapper(selectedIndex: $selectedIndex)
            PadsView(trackLockState: $trackLockState, selectedIndex: $selectedIndex)
            PlaybackView(position: $conductor.playbackPosition, segments: conductor.gridLength)
            ControlButtonsView(isPlaying: $conductor.isPlaying, trackLockState: $trackLockState)
        }.onAppear {
            conductor.start()
        }.onDisappear {
            conductor.stop()
        }
    }
}

struct EffectViewWrapper: View {
    @EnvironmentObject var conductor: Conductor
    @Binding var selectedIndex: Int
        
    var body: some View {
        EffectConfigurationView(configuration: $conductor.data[selectedIndex].configuration)
    }
}
