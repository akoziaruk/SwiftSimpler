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
    func orderDidChanged(for sampleChain: SampleChain)
}

class SampleChain {
    private let audioFile: AVAudioFile!
    private var sampler: Sampler!
    private var reverb: ZitaReverb!
    private var delay: Delay!
    private var distortion: Distortion!
    
    var delegate: SampleChainDelegate?
    var output: Node!
    var midiIn: MIDIEndpointRef {  sampler.midiIn }
    var configuration: EffectsConfig {
        didSet {
            if oldValue.order != configuration.order {
                delegate?.orderDidChanged(for: self)
            }
            if oldValue.distortion != configuration.distortion {
                distortion.update(with: configuration.distortion)
            }
            if oldValue.reverb != configuration.reverb {
                reverb.update(with: configuration.reverb)
            }
            if oldValue.delay != configuration.delay {
                delay.update(with: configuration.delay)
            }
        }
    }
    
    init(configuration: EffectsConfig, audioFileName: String, delegate: SampleChainDelegate) {
        self.configuration = configuration
        self.audioFile = AVAudioFile.audioFile(with: audioFileName)
        self.delegate = delegate
    }
    
    //MARK: - Public

    public func play() {
        sampler.play(noteNumber: MIDINoteNumber(60), velocity: 127, channel: 0)
    }
    
    public func recreateProcessingChain() {
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
        
        forceUpdateEffectsParameters()
    }
    
    //MARK: - Private
    
    private func forceUpdateEffectsParameters() {
        distortion.update(with: configuration.distortion)
        reverb.update(with: configuration.reverb)
        delay.update(with: configuration.delay)
    }
}
