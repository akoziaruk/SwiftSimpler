//
//  SimplerSequencer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AudioKit
import AVFoundation

protocol SimplerSequencerDelegate: AnyObject {
    func didChanged(position: Int, sequencer: SimplerSequencer)
}

class SimplerSequencer: AppleSequencer {
    private let grid = 4.0
    
    var position: Int {
        Int(currentRelativePosition.beats * grid)
    }

    var gridLength: Int {
        Int(length.beats * grid)
    }

    var midiEndpoints: [MIDIEndpointRef]! {
        didSet {
            // For each sequencer track set midi output to different sampler
            for (i, endpoint) in midiEndpoints.enumerated() {
                tracks[i].setMIDIOutput(endpoint)
            }
        }
    }
    
    var loopLength: Double = 4 {
        didSet {
            setLength(Duration(beats: loopLength))
            enableLooping()
        }
    }
    
    weak var delegate: SimplerSequencerDelegate?
    
    override init() {
        super.init()
        
        let fileURL = Bundle.main.url(forResource: "MIDI Files/16tracks", withExtension: "mid")!
        loadMIDIFile(fromURL: fileURL)
        
        debug()

        clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
        setTempo(120)
        setLength(Duration(beats: loopLength))
        enableLooping()
    }
    
    // TODO: This function can be opimized if only add/remove difference
    public func update(with sequence: [Velocity?], track: Int) {
        let track = tracks[track]
        
        track.clear()
        
        for (i, velocity) in sequence.enumerated() {
            if let velocity = velocity {
                let position = Duration(beats: Double(i) / 4.0)
                track.add(noteNumber: MIDINoteNumber(60),
                          velocity: velocity,
                          position: position,
                          duration: Duration(beats: loopLength))
                
            }
        }
        
        track.setLength(Duration(beats: loopLength))
    }
    
    //MARK: - Start/Stop
    
    func start() {
        super.play()
        
        startTimer()
    }
    
    func finish() {
        super.stop()
        super.rewind()
        
        stopTimer()
    }
    
    //MARK: - Position Update Timer
    
    private var displaylink: CADisplayLink?
    private var latestPosition = 0
    
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
        if position != latestPosition {
            delegate?.didChanged(position: position, sequencer: self)
            latestPosition = position
        }
    }
}
