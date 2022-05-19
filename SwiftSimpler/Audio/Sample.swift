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

class SampleChain {
    private let audioFile: AVAudioFile!
    
    private var sampler: Sampler!
    private var reverb: ZitaReverb!
    private var delay: Delay!
    private var distortion: Distortion!
    
    var output: Node!

    var effectsOrder = [Effect]()
        
    var effects = EffectsConfig() {
        didSet {
            updateEffectsParameters()
        }
    }
    
    init(audioFile: AVAudioFile) {
        self.audioFile = audioFile
    }
    
//    public func prepareForUpdate() {
//        sampler?.destroyEndpoint()
//    }
//    
    public func recreateProcessingChain() {
        sampler = Sampler(audioFile: audioFile)
        
        var node: Node = sampler
        
        for effect in effectsOrder {
            switch effect {
            case .distortion:
                distortion = Distortion(node)
                node = distortion
            case .delay:
                delay = Delay(node)
                node = delay
            case .reverb:
                reverb = ZitaReverb(node)
                node = reverb
            }
        }
        
        output = node
        
        updateEffectsParameters()
    }
    
    private func updateEffectsParameters() {
        guard let distortion = distortion else { return }
        
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

    func play() {
        sampler.play(noteNumber: MIDINoteNumber(60), velocity: 127, channel: 0)
    }
}
