//
//  SimplerSampler.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AVKit
import AudioKit

struct EffectsConfig {
    var distortion: Float = 30
    var delay: Float = 0.1
    var reverb: Float = 0.4
}

class Sample {
    private let sampler: MIDISampler!
    let distortion: Distortion!
    let reverb: Reverb!
    let delay: Delay!
    
    var effects = EffectsConfig() {
        didSet {
            updateEffectsChain()
        }
    }
    
    init(audioFile: AVAudioFile) {
        sampler = MIDISampler()
        distortion = Distortion(sampler)
        reverb = Reverb(distortion)
        delay = Delay(reverb)
                
        updateEffectsChain()
        
        do {
            try sampler.loadAudioFile(audioFile)
        } catch {
            print("Files Didn't Load")
        }
        
    }
    
    private func updateEffectsChain() {
        delay.dryWetMix = effects.delay
        reverb.dryWetMix = effects.reverb
        distortion.finalMix = effects.distortion
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
