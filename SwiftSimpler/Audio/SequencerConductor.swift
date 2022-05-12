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
    public var sampler: SimplerSampler!
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

        sequencer.updateSequencer(note: sampler.note(for: activeTrackIndex),
                                  trackIndex: activeTrackIndex,
                                  position: position,
                                  activate: lockedSampleSequence[position])
    }
    
    //MARK: - Initialisation
    
    init() {
        sampler = SimplerSampler()
        sequencer = SimplerSequencer(sampler.midiIn)
        engine = AudioEngine()
        engine.output = sampler
        
        
        // create mixer
        let mixer1 = Mixer([], name: "Mixer 1")
        
        let mixer2 = Mixer([], name: "Mixer 2")

        let mixerMaster = Mixer([mixer1, mixer2], name: "Mixer Master")
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
