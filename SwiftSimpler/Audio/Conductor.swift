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
                sequencer.play()
            } else {
                sequencer.stop()
            }
        }
    }
    
    @Published var effectsConfigurations: [EffectsConfig] {
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
    private var sampleChains: [SampleChain]!
    private var sequencer: SimplerSequencer!

    public var sampleCount: Int { sampleChains.count }
    public var gridLength: Int  { 16 }
    
    init() {
        let audioFileNames = AudioFileManager.all()
        let configurations =  audioFileNames.map { _ in EffectsConfig() }
        
        sequencer = SimplerSequencer()
        sequences = configurations.map { _ in
            [Velocity?](repeating: nil, count: 16)
        }
        effectsConfigurations = configurations
        sampleChains = zip(configurations, audioFileNames).map {
            SampleChain(configuration: $0, audioFileName: $1, delegate: self)
        }
        
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
        for sample in sampleChains {
            sample.recreateProcessingChain()
        }
        
        let outputs = sampleChains.compactMap { $0.output }
        engine.output = Mixer(outputs, name: "Mixer Master")
        
        sequencer.midiEndpoints = sampleChains.map { $0.midiIn }
    }
}

extension Conductor: SampleChainDelegate {
    func orderDidChanged(for sampleChain: SampleChain) {
        // All chain should be recreated if any nodes order is chainged
        recreateProcessingChain()
    }
}
