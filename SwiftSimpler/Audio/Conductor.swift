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
    var sampleSequence = [Bool]()
    var isPlaying = false
    var tempo: Double = 120
}

class Conductor: ObservableObject {
    public var samples = [Sample]()
    public var sequencer: SimplerSequencer!
    public let engine: AudioEngine!
    private var sampleSequence = [Bool]()

    @Published var playbackPosition: Int = 0
    
    @Published var data = SimplerData() {
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
            
            let sample = samples[activeTrackIndex]
            sample.effects = data.effects
        }
    }
    
    //MARK: - Handling Actions
    
    var activeTrackIndex: Int! {
        didSet {
            let sample = samples[activeTrackIndex]
            data.effects = sample.effects
            data.sampleSequence = sequencer.getSequence(for: activeTrackIndex)
        }
    }
        
    public func playPad(at index: Int) {
        samples[index].play()
    }
    
    //MARK: - Initialisation
    
    init() {
        engine = AudioEngine()

        let files = AudioFileManager.all()
        samples = files.map { Sample(audioFile: $0) }
        
        let midiInputs = samples.map { $0.midiIn }
        sequencer = SimplerSequencer(midiInputs)
        
        let audioOutputs = samples.map { $0.output }
        engine.output = Mixer(audioOutputs, name: "Mixer Master")
        
        activeTrackIndex = 0
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
