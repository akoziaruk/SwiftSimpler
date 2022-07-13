//
//  Conductor.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 23.05.2022.
//

import Foundation
import AudioKit
import SwiftUI

class Conductor: ObservableObject {
    @Published var playbackData = PlaybackData() {
        didSet {
            if playbackData.isPlaying != oldValue.isPlaying {
                if playbackData.isPlaying {
                    sequencer.start()
                } else {
                    sequencer.finish()
                }
            }
            
            if playbackData.tempo != oldValue.tempo {
                sequencer.setTempo(Double(playbackData.tempo))
            }
            
            if playbackData.length != oldValue.length {
                sequencer.loopLength = Double(playbackData.length * 4)
                forceUpdateSequencerData()
            }
        }
    }
    
    // TODO: Refactor to have separate publisher for each seqence
    @Published var sequenceData: [SequenceData]! {
        didSet {
            forceUpdateSequencerData()
        }
    }
    
    var samples: [SampleChannel]!

    private let engine = AudioEngine()
    private var sequencer: SimplerSequencer!

    public var gridLength: Int  { sequencer.gridLength }
    public var position: Int {  sequencer.position % 16 }

    init() {
        let audioFileNames = AudioFileManager.all()
        
        //TODO: Restore session effects here
        let configurations = audioFileNames.map { _ in EffectsConfiguration() }
        
        //TODO: Restore sequences here
        sequenceData = audioFileNames.map { _ in SequenceData() }
                
        samples = zip(configurations, audioFileNames).map {
            SampleChannel(configuration: $0, audioFileName: $1, delegate: self)
        }
        
        sequencer = SimplerSequencer()
        sequencer.delegate = self
        
        recreateProcessingChain()
    }
    
    //MARK: - Start/Stop

    public func startEngine() {
        do {
            try engine.start()
        } catch {
            print("AudioEngine did not start! \(error)")
        }
    }

    public func stopEngine() {
        engine.stop()
    }
    
    //MARK: - Handling nodes routing
    
    private func recreateProcessingChain() {
        playbackData.isPlaying = false
        
        stopEngine()
        
        for sample in samples {
            sample.recreateProcessingChain()
        }
        
        let outputs = samples.compactMap { $0.output }
        engine.output = Mixer(outputs, name: "Mixer Master")
        
        sequencer.midiEndpoints = samples.map { $0.midiIn }
        
        startEngine()
    }
    
    //MARK: - Sequencer data management
    
    private func forceUpdateSequencerData() {
        guard let sequencer = sequencer else { return }
        
        for (index, sequence) in sequenceData.enumerated() {
            sequencer.update(with: sequence.combined(), track: index)
        }
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
        if playbackData.position != position {
            playbackData.position = position
        }
    }
}
