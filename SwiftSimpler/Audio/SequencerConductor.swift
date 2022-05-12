//
//  SequencerConductor.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 06.05.2022.
//

import Foundation
import AudioKit
import AVKit

class SequencerConductor: ObservableObject {
    public var samples: [Sample]
    public var sequencer: SimplerSequencer!
    public let engine: AudioEngine!
            
    @Published var isPlaying = false {
        didSet {
            if isPlaying {
                sequencer.play()
                startTimer()
            } else {
                sequencer.stop()
                stopTimer()
            }
        }
    }
    
    @Published var tempo: Double = 120 {
        didSet {
            sequencer.setTempo(tempo)
        }
    }

    @Published var lockedSampleSequence: [Bool]!
    @Published var playbackPosition: Int = 0
    
    //MARK: - Actions Handling
    
    var activeTrackIndex: Int = 0 {
        didSet {
            lockedSampleSequence = sequencer.getSequence(for: activeTrackIndex)
        }
    }

    public func updateActiveTrackSequence(at position: Int) {
        lockedSampleSequence[position].toggle()

        sequencer.updateSequencer(trackIndex: activeTrackIndex,
                                  position: position,
                                  activate: lockedSampleSequence[position])
    }
    
    //MARK: - Initialisation
    
    var sampleCount: Int {
        return samples.count
    }
    
    init() {
        engine = AudioEngine()

        let files = AudioFileManager.all()
        samples = files.map { Sample(audioFile: $0) }
        
        let midiInputs = samples.map { $0.midiIn }
        sequencer = SimplerSequencer(midiInputs)
        
        let audioOutputs = samples.map { $0.output }
        engine.output = Mixer(audioOutputs, name: "Mixer Master")
    }
    
    public func playPad(at index: Int) {
        samples[index].play()
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

    //MARK: - Position update timer
    
    private var displaylink: CADisplayLink!

    private func startTimer() {
        displaylink = CADisplayLink(
            target: self,
            selector: #selector(updatePosition)
        )
        displaylink.add(to: .main, forMode: .default)
    }
    
    private func stopTimer() {
        updatePosition()
        displaylink.invalidate()
    }
    
    @objc
    private func updatePosition() {
        let newPosition = sequencer.position
        if newPosition != playbackPosition {
            playbackPosition = newPosition
        }
    }
}
