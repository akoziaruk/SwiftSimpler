//
//  AudioFileManager.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AVKit

class AudioFileManager {
    private static let fileNames = ["bass_drum.wav",
                                    "snare.wav",
                                    "clap.wav",
                                    "closed_hi_hat.wav",
                                    "open_hi_hat.wav",
                                    "hi_tom.wav"]
    
    static func all() -> [AVAudioFile] {
       return fileNames.compactMap { AVAudioFile.audioFile(with: $0) }
    }
}
