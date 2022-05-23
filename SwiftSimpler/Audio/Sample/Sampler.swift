//
//  Sampler.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import AudioKit
import AVKit

class Sampler: MIDISampler {
    init(audioFile: AVAudioFile) {
        super.init()
        
        do {
            try self.loadAudioFile(audioFile)
        } catch {
            print("Files Didn't Load")
        }
    }
}

