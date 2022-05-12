//
//  SimplerSequencer.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import Foundation
import AudioKit
import AVFoundation

class SimplerSequencer: AppleSequencer {
    private let grid = 4.0
    
    var position: Int {
        Int(currentRelativePosition.beats * grid)
    }

    var gridLength: Int {
        Int(length.beats * grid)
    }
    
    init(_ midiEndpoint: MIDIEndpointRef) {
        super.init()
        
        let fileURL = Bundle.main.url(forResource: "MIDI Files/16tracks", withExtension: "mid")!
        loadMIDIFile(fromURL: fileURL)
        
        debug()

        clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
        setGlobalMIDIOutput(midiEndpoint)
        
        
        
        // for each sequencer track set midi output to different sampler
//        for (i, track) in tracks.enumerated() {
//            track.setMIDIOutput(midiEndpoints[i])
//        }
//
        
        setTempo(120)
        setLength(Duration(beats: 4))
        enableLooping()
    }
    
    public func updateSequencer(note: MIDINoteNumber, trackIndex: Int, position: Int, activate: Bool) {
        let track = tracks[trackIndex]

        let position = Duration(beats: Double(position) / 4.0)

        if activate {
            track.add(noteNumber: note,
                      velocity: 127,
                      position: position,
                      duration: Duration(beats: 1))
            
            track.setLength(Duration(beats: 4))
        } else {
            track.clearRange(start: position,
                             duration: Duration(beats: 0.25))
        }
    }
        
    public func getSequence(for sampleIndex: Int) -> [Bool] {
        let track = tracks[sampleIndex]
        var result = [Bool](repeating: false, count: Int(length.beats*grid))
        
        let midiData = track.getMIDINoteData()
        for midi in midiData {
            let position = Int(midi.position.beats * grid)
            result[position] = true
        }
        
        return result
    }

}
