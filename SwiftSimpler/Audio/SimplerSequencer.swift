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
    
    init(_ midiEndpoints: [MIDIEndpointRef]) {
        super.init()
        
        let fileURL = Bundle.main.url(forResource: "MIDI Files/16tracks", withExtension: "mid")!
        loadMIDIFile(fromURL: fileURL)
        
        debug()

        clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
        
        // For each sequencer track set midi output to different sampler
        for (i, endpoint) in midiEndpoints.enumerated() {
            tracks[i].setMIDIOutput(endpoint)
        }
        
        setTempo(120)
        setLength(Duration(beats: 4))
        enableLooping()
    }
    
    // TODO: This function can be opimized if only add/remove difference
    public func update(with sequence: [Bool], track: Int) {
        let track = tracks[track]
        
        track.clear()
        
        for (i, value) in sequence.enumerated() {
            if value {
                let position = Duration(beats: Double(i) / 4.0)
                track.add(noteNumber: MIDINoteNumber(60),
                          velocity: 127,
                          position: position,
                          duration: Duration(beats: 4))
                
            }
        }
        
        track.setLength(Duration(beats: 4))
    }
//
//    func updateSequence(with value: Bool, track: Int, position: Int) {
//        let track = tracks[track]
//        let position = Duration(beats: Double(position) / 4.0)
//
//        if value {
//           track.add(noteNumber: MIDINoteNumber(60),
//                     velocity: 127,
//                     position: position,
//                     duration: Duration(beats: 4))
//
//            track.setLength(Duration(beats: 4))
//        } else {
//            track.clearRange(start: position, duration: Duration(beats: 0.25))
//        }
//    }
        
    public func getSequence(for sampleIndex: Int) -> [Bool] {
        let track = tracks[sampleIndex]
        var result = [Bool](repeating: false, count: Int(length.beats*grid))
        
        let midiData = track.getMIDINoteData()
        for midi in midiData {
            let position = Int(midi.position.beats*grid)
            result[position] = true
        }
        
        return result
    }

}
