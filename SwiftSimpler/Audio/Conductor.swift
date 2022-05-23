//
//  Conductor.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit

typealias Velocity = MIDIVelocity

struct SampleData {
    var configuration: EffectsConfig
    var sequence: [Velocity?]
}

class Conductor: ObservableObject {
    @Published var isPlaying = false
    @Published var playbackPosition = 0
    
    @Published var data: [SampleData] {
        didSet {
            for (i, sampleData) in data.enumerated() {
                sampleChains[i].configuration = sampleData.configuration
            }
        }
    }
        
    private var sampleChains: [SampleChain]!
    private let engine = AudioEngine()

    public var sampleCount: Int { sampleChains.count }
    public var gridLength: Int  { 16 }
    
    
    init() {
        let audioFileNames = AudioFileManager.all()
        let configurations = audioFileNames.map { _ in EffectsConfig() }
        
        data = configurations.map {
            SampleData(configuration: $0, sequence: [Velocity?](repeating: nil, count: 16))
        }
        
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
    }
}

extension Conductor: SampleChainDelegate {
    func orderDidChanged(for sampleChain: SampleChain) {
        // All chain should be recreated if any nodes order is chainged
        recreateProcessingChain()
    }
}
