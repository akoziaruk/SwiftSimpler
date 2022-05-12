//
//  SimplerSampler.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AVKit
import AudioKit

struct Sample {
    let midiNote: MIDINoteNumber
    var audioFile: AVAudioFile?
    init(midiNote: Int, fileName: String) {
        self.midiNote = MIDINoteNumber(midiNote)
        self.audioFile = AVAudioFile.audioFile(with: fileName)
    }
}

class SimplerSampler: MIDISampler {
    var samples = [Sample(midiNote: 24, fileName: "bass_drum_C1.wav"),
                   Sample(midiNote: 26, fileName: "snare_D1.wav"),
                   Sample(midiNote: 27, fileName: "clap_D#1.wav"),
                   Sample(midiNote: 30, fileName: "closed_hi_hat_F#1.wav"),
                   Sample(midiNote: 34, fileName: "open_hi_hat_A#1.wav"),
                   Sample(midiNote: 38, fileName: "hi_tom_D2.wav")]
    
    var sampleCount: Int {
        return samples.count
    }
    
    init() {
        super.init(name: "Drums")
        
        do {
            let files = samples.compactMap { $0.audioFile }
            try loadAudioFiles(files)
        } catch {
            print("Files Didn't Load")
        }
    }
    
    public func playPad(at track: Int) {
        play(noteNumber: note(for: track), velocity: 127, channel: 0)
    }
    
    public func note(for track: Int) -> MIDINoteNumber {
        samples[track].midiNote
    }
}
