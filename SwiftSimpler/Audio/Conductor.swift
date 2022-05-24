//
//  Conductor.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit
import SwiftUI

typealias Velocity = MIDIVelocity
typealias Sequence = [Velocity?]

struct Data {
    var playbackPosition = 0
    var isPlaying = false
    var tempo: Double = 120
}

class Conductor: ObservableObject {
    @Published var data = Data() {
        didSet {
            if oldValue.isPlaying != data.isPlaying {
                if data.isPlaying {
                    sequencer.start()
                } else {
                    sequencer.finish()
                }
            }
            
            if oldValue.tempo != data.tempo {
                sequencer.setTempo(data.tempo)
            }
        }
    }
    
    @Published var effectsConfigurations: [EffectsConfiguration] {
        didSet {
            for (index, configuration) in effectsConfigurations.enumerated() {
                sampleChains[index].configuration = configuration
            }
        }
    }
    @Published var sequences: [Sequence] {
        didSet {
            for (index, sequence) in sequences.enumerated() {
                if oldValue[index] != sequence {
                    sequencer.update(with: sequence, track: index)
                }
            }
        }
    }

    private let engine = AudioEngine()
    private var sampleChains: [SampleChannel]!
    private var sequencer: SimplerSequencer!

    public var sampleCount: Int { sampleChains.count }
    public var gridLength: Int  { sequencer.gridLength }
    
    init() {
        let audioFileNames = AudioFileManager.all()
        
        // restore effects
        let configurations = audioFileNames.map { _ in EffectsConfiguration() }
        
        // restore sequences
        sequences = audioFileNames.map { _ in [Velocity?](repeating: nil, count: 16) }
        
        effectsConfigurations = configurations
        sampleChains = zip(configurations, audioFileNames).map {
            SampleChannel(configuration: $0, audioFileName: $1, delegate: self)
        }
        
        sequencer = SimplerSequencer()
        sequencer.delegate = self
        
        recreateProcessingChain()
    }
    
    //MARK: - Action
    
    public func playPad(at index: Int) {
        sampleChains[index].play()
    }
    
    //MARK: - Start/Stop

    public func start() {
        do {
            try engine.start()
        } catch {
            print("AudioEngine did not start! \(error)")
        }
    }

    public func stop() {
        engine.stop()
    }
    
    //MARK: - Handling nodes routing
    
    func recreateProcessingChain() {
        data.isPlaying = false
        
        for sample in sampleChains {
            sample.recreateProcessingChain()
        }
        
        let outputs = sampleChains.compactMap { $0.output }
        engine.output = Mixer(outputs, name: "Mixer Master")
        
        sequencer.midiEndpoints = sampleChains.map { $0.midiIn }
    }
}

extension Conductor: SampleChannelDelegate {
    func orderDidChanged(for sampleChain: SampleChannel) {
        // All chain should be recreated if any nodes order is chainged
        recreateProcessingChain()
    }
}

extension Conductor: SimplerSequencerDelegate {
    func didChanged(position: Int, sequencer: SimplerSequencer) {
        data.playbackPosition = position
    }
}
