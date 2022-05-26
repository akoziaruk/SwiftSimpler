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
    
    @State var selectedTrack = 0
    @State var trackLockState = TrackLockState.none
    
    var body: some View {
        VStack {
            EffectConfigurationView(effect: $conductor.samples[selectedTrack].configuration)

            ControlsView(trackLockState: $trackLockState)
                        
            PadsView(trackLockState: $trackLockState,
                     selectedTrack: $selectedTrack)
            
            PlaybackView()
        }.onAppear {
            conductor.start()
        }.onDisappear {
            conductor.stop()
        }
    }
}
