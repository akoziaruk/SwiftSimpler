//
//  SimplerSampler.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AVKit
import AudioKit

class Sample {
    private let sampler: MIDISampler!
    private let distortion: Distortion!
    private let reverb: Reverb!
    private let delay: Delay!
        
    init(audioFile: AVAudioFile) {
        sampler = MIDISampler()
        distortion = Distortion(sampler)
        reverb = Reverb(distortion)
        delay = Delay(reverb)
        
        do {
            try sampler.loadAudioFile(audioFile)
        } catch {
            print("Files Didn't Load")
        }
        
    }
    
    var midiIn: MIDIEndpointRef {
        sampler.midiIn
    }
    
    var output: Node {
        //TODO: return last item in chain
        delay
    }
    
    func play() {
        sampler.play(noteNumber: MIDINoteNumber(60), velocity: 127, channel: 0)
    }
}
