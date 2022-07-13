//
//  SampleChannel.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AVKit
import AudioKit
import SoundpipeAudioKit
import DunneAudioKit

protocol SampleChannelDelegate: AnyObject {
    func orderDidChanged(for sampleChain: SampleChannel)
}

class SampleChannel: ObservableObject {
    private let audioFile: AVAudioFile!
    private var sampler: Sampler!
    
    private var reverb: ZitaReverb!
    private var delay: Delay!
    private var distortion: Distortion!
    private var flanger: Flanger!

    private var equalizer1: EqualizerFilter!
    private var equalizer2: EqualizerFilter!
    private var hpFiler: HighPassButterworthFilter!
    private var lpFilter: LowPassButterworthFilter!

    private var mixer: Mixer!
    
    var output: Node { mixer }
    var midiIn: MIDIEndpointRef {  sampler.midiIn }
    weak var delegate: SampleChannelDelegate?

    
    @Published var configuration: EffectsConfiguration {
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
            if oldValue.mixer != configuration.mixer {
                mixer.update(with: configuration.mixer)
            }
            if oldValue.equalizer1 != configuration.equalizer1 {
                equalizer1.update(with: configuration.equalizer1)
            }
            if oldValue.equalizer2 != configuration.equalizer2 {
                equalizer2.update(with: configuration.equalizer2)
            }
            if oldValue.hpf != configuration.hpf {
                hpFiler.update(with: configuration.hpf)
            }
            if oldValue.lpf != configuration.lpf {
                lpFilter.update(with: configuration.lpf)
            }
            if oldValue.flanger != configuration.flanger {
                flanger.update(with: configuration.flanger)
            }
        }
    }
    
    init(configuration: EffectsConfiguration, audioFileName: String, delegate: SampleChannelDelegate) {
        self.configuration = configuration
        self.audioFile = AVAudioFile.audioFile(with: audioFileName)
        self.delegate = delegate
    }
    
    //MARK: - Public

    public func play() {
        sampler.play(noteNumber: MIDINoteNumber(60), velocity: Velocity.max, channel: 0)
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
                
            case .flanger:
                
                flanger = Flanger(node)
                node =  flanger
                
            case .equalizer:
                
                equalizer1 = EqualizerFilter(node)
                equalizer2 = EqualizerFilter(equalizer1)

                node = equalizer2
                
            case .cutoff:

                lpFilter = LowPassButterworthFilter(node)
                hpFiler = HighPassButterworthFilter(lpFilter)

                node = hpFiler

            }
        }
        
        mixer = Mixer(node)
        
        forceUpdateEffectsParameters()
    }
    
    //MARK: - Private
    
    private func forceUpdateEffectsParameters() {
        distortion.update(with: configuration.distortion)
        reverb.update(with: configuration.reverb)
        delay.update(with: configuration.delay)
        equalizer1.update(with: configuration.equalizer1)
        equalizer1.update(with: configuration.equalizer1)
        hpFiler.update(with: configuration.hpf)
        lpFilter.update(with: configuration.lpf)
    }
}
