//
//  Sample.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AVKit
import AudioKit
import SoundpipeAudioKit

class Sample {
    private let sampler: MIDISampler!
    let reverb: ZitaReverb!
    let delay: Delay!
    let distortion: Distortion!

    var effects = EffectsConfig() {
        didSet {
            updateEffectsChain()
        }
    }
    
    init(audioFile: AVAudioFile) {
        sampler = MIDISampler()
        delay = Delay(sampler)
        reverb = ZitaReverb(delay)
        distortion = Distortion(reverb)

        updateEffectsChain()
        
        do {
            try sampler.loadAudioFile(audioFile)
        } catch {
            print("Files Didn't Load")
        }
    }
    
    private func updateEffectsChain() {

        // Distortion
        distortion.rounding = effects.distortion.rounding.value
        distortion.decimation = effects.distortion.decimation.value
        distortion.softClipGain = effects.distortion.softClip.value
        distortion.ringModFreq1 = effects.distortion.modFreq.value
        distortion.decay = effects.distortion.decay.value
        distortion.finalMix = effects.distortion.mix.value

        // Reverb
        reverb.crossoverFrequency = effects.reverb.crossoverFrequency.value
        reverb.predelay = effects.reverb.predelay.value
        reverb.midReleaseTime = effects.reverb.midReleaseTime.value
        reverb.dampingFrequency = effects.reverb.dampingFrequency.value
        reverb.equalizerFrequency1 = effects.reverb.equalizerFrequency.value
        reverb.dryWetMix = effects.reverb.mix.value
        
        //Delay
        delay.lowPassCutoff = effects.delay.lowPassCutoff.value
        delay.feedback = effects.delay.feedback.value
        delay.time = effects.delay.time.value
        delay.dryWetMix = effects.delay.mix.value
    }
    
    var midiIn: MIDIEndpointRef {
        sampler.midiIn
    }
    
    var output: Node {
        //TODO: return last item in chain
        distortion
    }

    func play() {
        sampler.play(noteNumber: MIDINoteNumber(60), velocity: 127, channel: 0)
    }
}
