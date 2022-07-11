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
    @Published var playbackData = PlayBackData() {
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
            
            if playbackData.playback.length != oldValue.playback.length {
                sequencer.loopLength = Double(playbackData.playback.length * 4)
                forceUpdateSequencerData()
            }
        }
    }
    
    var samples: [SampleChannel]!

    // TODO: Refactor to have separate publisher for each seqence
    @Published var sequenceData: [SequenceData]! {
        didSet {
            forceUpdateSequencerData()
        }
    }
    
//    @Published var sequences: [Sequence]! {
//        didSet {
//            for (index, sequence) in sequences.enumerated() {
//                if let oldValue = oldValue {
//                    if oldValue[index] != sequence {
//                        sequencer.update(with: sequence, beat: <#Int#>, track: index)
//                    }
//                }
//            }
//        }
//    }
    
    private func forceUpdateSequencerData() {
        guard let sequencer = sequencer else { return }
        
        for (index, sequence) in sequenceData.enumerated() {
            sequencer.update(with: sequence.combined(), track: index)
        }
    }

    private let engine = AudioEngine()
    private var sequencer: SimplerSequencer!

    public var gridLength: Int  { sequencer.gridLength }
    public var position: Int {  sequencer.position % 16 }

    init() {
        let audioFileNames = AudioFileManager.all()
        
        // restore effects
        let configurations = audioFileNames.map { _ in EffectsConfiguration() }
        
        // restore sequences
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
    
    func recreateProcessingChain() {
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
}

extension Conductor: SampleChannelDelegate {
    func orderDidChanged(for sampleChain: SampleChannel) {
        // All chain should be recreated if any nodes order is chainged
        recreateProcessingChain()
    }
}

extension Conductor: SimplerSequencerDelegate {
    func didChanged(position: Int, sequencer: SimplerSequencer) {
        if playbackData.playback.position != position {
            playbackData.playback.position = position
        }
    }
}
