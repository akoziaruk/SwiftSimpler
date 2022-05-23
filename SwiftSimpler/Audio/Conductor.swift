//
//  Conductor.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

typealias Velocity = MIDIVelocity
typealias Sequence = [Velocity?]

class Conductor: ObservableObject {
    @Published var playbackPosition = 0
    @Published var isPlaying = false {
        didSet {
            if isPlaying {
                sequencer.start()
            } else {
                sequencer.finish()
            }
        }
    }
    
    @Published var tempo: Double = 120 {
        didSet {
            sequencer.setTempo(tempo)
        }
    }
    
    @Published var effectsConfigurations: [EffectsConfiguration] {
        didSet {
            for (i, configuration) in effectsConfigurations.enumerated() {
                sampleChains[i].configuration = configuration
            }
        }
    }
    
    @Published var sequences: [Sequence] {
        didSet {
            for (i, sequence) in sequences.enumerated() {
                if sequence != oldValue[i] {
                    sequencer.update(with: sequence, track: i)
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
        isPlaying = false
        
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
        playbackPosition = position
    }
}
