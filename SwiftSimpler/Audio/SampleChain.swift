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

protocol SampleChainDelegate: AnyObject {
    func chainOrderConfigurationChanged(for sampleChain: SampleChain)
}

class SampleChain {
    private let audioFile: AVAudioFile!
    
    private var sampler: Sampler!
    private var reverb: ZitaReverb!
    private var delay: Delay!
    private var distortion: Distortion!
    
    var output: Node!
        
    var configuration: EffectsConfig {
        didSet {
            if oldValue.order != configuration.order {
                print("chainOrderConfigurationChanged: \(configuration.order)")
                delegate?.chainOrderConfigurationChanged(for: self)
            }
            updateEffectsParameters()
        }
    }
    
    var delegate: SampleChainDelegate?
    
    init(configuration: EffectsConfig, audioFileName: String, delegate: SampleChainDelegate) {
        self.configuration = configuration
        self.audioFile = AVAudioFile.audioFile(with: audioFileName)
        self.delegate = delegate
        
        recreateProcessingChain()
    }

    public func recreateProcessingChain() {
        print("Recreating Processing Chain for \(String(describing: audioFile))")
        
        sampler = Sampler(audioFile: audioFile)
        
        var node: Node = sampler
        
        for effect in configuration.order {
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
        distortion.rounding = configuration.distortion.rounding.value
        distortion.decimation = configuration.distortion.decimation.value
        distortion.softClipGain = configuration.distortion.softClip.value
        distortion.ringModFreq1 = configuration.distortion.modFreq.value
        distortion.decay = configuration.distortion.decay.value
        distortion.finalMix = configuration.distortion.mix.value

        // Reverb
        reverb.crossoverFrequency = configuration.reverb.crossoverFrequency.value
        reverb.predelay = configuration.reverb.predelay.value
        reverb.midReleaseTime = configuration.reverb.midReleaseTime.value
        reverb.dampingFrequency = configuration.reverb.dampingFrequency.value
        reverb.equalizerFrequency1 = configuration.reverb.equalizerFrequency.value
        reverb.dryWetMix = configuration.reverb.mix.value
        
        //Delay
        delay.lowPassCutoff = configuration.delay.lowPassCutoff.value
        delay.feedback = configuration.delay.feedback.value
        delay.time = configuration.delay.time.value
        delay.dryWetMix = configuration.delay.mix.value
    }
    
    var midiIn: MIDIEndpointRef {
        sampler.midiIn
    }

    func play() {
        sampler.play(noteNumber: MIDINoteNumber(60), velocity: 127, channel: 0)
    }
}
