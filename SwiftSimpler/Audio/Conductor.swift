//
//  SequencerConductor.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 06.05.2022.
//

import Foundation
import AudioKit
import AVKit

struct SimplerData {
    var effects = EffectsConfig()
    var effectsOrder: [Effect] = [.distortion, .delay, .reverb]
    var sampleSequence = [Bool]()
    var isPlaying = false
    var tempo: Double = 120
}

class Conductor: ObservableObject {
    public var samples = [SampleChain]()
    public var sequencer: SimplerSequencer!
    public let engine: AudioEngine!
    private var sampleSequence = [Bool]()

    private var activeSample: SampleChain {
        return samples[activeTrackIndex]
    }
    
    @Published var playbackPosition: Int = 0
    
    @Published var data: SimplerData! {
        didSet {
            if data.isPlaying {
                sequencer.play()
                startTimer()
            } else {
                sequencer.stop()
                stopTimer()
            }
            
            if sequencer.tempo != data.tempo {
                sequencer.setTempo(data.tempo)
            }
            
            if sampleSequence != data.sampleSequence {
                sequencer.update(with: data.sampleSequence, track: activeTrackIndex)
                sampleSequence = data.sampleSequence
            }
            
            if activeSample.effectsOrder != data.effectsOrder {
                activeSample.effectsOrder = data.effectsOrder
                recreateProcessingChain()
            }
            
            if activeSample.effects != data.effects {
                activeSample.effects = data.effects
            }
        }
    }
    
    //MARK: - Processing Chain Update
    
    // To update effects order ALL audio processing chain should be recreated
    private func recreateProcessingChain() {
        data.isPlaying = false
        stop()
        
        samples.forEach { $0.recreateProcessingChain() }
        sequencer.midiEndpoints = samples.map { $0.midiIn }
        
        let outputs = samples.compactMap { $0.output }
        engine.output = Mixer(outputs, name: "Mixer Master")
        
        start()
    }

    //MARK: - Handling Actions
    
    var activeTrackIndex: Int! {
        didSet {
//            data.effectsOrder = activeSample.effectsOrder
            data.effects = activeSample.effects
            data.sampleSequence = sequencer.getSequence(for: activeTrackIndex)
        }
    }
        
    public func playPad(at index: Int) {
        samples[index].play()
    }
    
    //MARK: - Initialisation
    
    init() {
        activeTrackIndex = 0
        engine = AudioEngine()
        samples = AudioFileManager.all()
            .map { SampleChain(audioFile: $0) }
        sequencer = SimplerSequencer()
        data = SimplerData()
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

    //MARK: - Position Update Timer
    
    private var displaylink: CADisplayLink?

    private func startTimer() {
        if displaylink == nil {
            displaylink = CADisplayLink(target: self, selector: #selector(updatePosition))
            displaylink?.add(to: .main, forMode: .default)
        }
    }
    
    private func stopTimer() {
        updatePosition()
        displaylink?.invalidate()
        displaylink = nil
    }
    
    @objc
    private func updatePosition() {
        let newPosition = sequencer.position
        if newPosition != playbackPosition {
            playbackPosition = newPosition
        }
    }
}
