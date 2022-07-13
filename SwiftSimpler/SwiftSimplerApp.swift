//
//  SwiftSimplerApp.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 05.05.2022.
//

import SwiftUI
import AVFoundation
import AudioKit

@main
struct SwiftSimplerApp: App {
    init() {
#if os(iOS)
        do {
            Settings.bufferLength = .short
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                                            options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let err {
            print(err)
        }
#endif
    }
    
    let conductor = Conductor()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(conductor)
        }
    }
}
