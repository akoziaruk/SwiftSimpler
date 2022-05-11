//
//  SimplerEngine.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.05.2022.
//

import Foundation
import AudioKit
import AudioKitEX
import AVKit

struct Sample {
    let midiNote: Int
    var audioFile: AVAudioFile?
    init(midiNote: Int, fileName: String) {
        self.midiNote = midiNote
        self.audioFile = AVAudioFile.audioFile(with: fileName)
    }
}

class SimplerEngine {
    private let engine = AudioEngine()
    private let drums = MIDISampler(name: "Drums")
    private let sequencer = AppleSequencer(fromURL: Bundle.main.url(forResource: "MIDI Files/16tracks", withExtension: "mid")!)
    private var callbackInst: CallbackInstrument!

    public var length = 16
    
    var samples = [Sample(midiNote: 24, fileName: "bass_drum_C1.wav"),
                   Sample(midiNote: 26, fileName: "snare_D1.wav"),
                   Sample(midiNote: 27, fileName: "clap_D#1.wav"),
                   Sample(midiNote: 30, fileName: "closed_hi_hat_F#1.wav"),
                   Sample(midiNote: 34, fileName: "open_hi_hat_A#1.wav"),
                   Sample(midiNote: 38, fileName: "hi_tom_D2.wav")]
 
    var positionCallback: ((Int)->())?
    
    init() {
        engine.output = drums
        
        callbackInst = CallbackInstrument(midiCallback: { [weak self] (_, beat, _) in
            self?.positionCallback?(Int(beat))
        })
        
//        sequencer.addTrack(for: callbackInst)
    }
    
    public func playbackPosition() -> Double {
        sequencer.currentRelativePosition.beats * 4
    }
    
    public func startPlay() {
        sequencer.play()
    }
    
    public func stopPlay() {
        sequencer.stop()
        sequencer.rewind()
    }
    
    public func set(tempo: Float) {
        sequencer.setTempo(BPM(tempo))
    }
    
    public func updateSequencer(sampleIndex: Int, position: Int, activate: Bool) {
        let track = sequencer.tracks[sampleIndex]

        let position = Duration(beats: Double(position) / 4.0)
        let duration = Duration(beats: 0.25)

        if activate {
            let sample = samples[sampleIndex]
            track.add(noteNumber: MIDINoteNumber(sample.midiNote),
                      velocity: 127,
                      position: position,
                      duration: duration)
        } else {
            track.clearRange(start: position,
                             duration: duration)
        }
    }
    
    public func playPad(with number: Int) {
        let node = MIDINoteNumber(samples[number].midiNote)
        drums.play(noteNumber: node, velocity: 127, channel: 0)
    }
    
    public func getSequence(for sampleIndex: Int) -> [Bool] {
        let track = sequencer.tracks[sampleIndex]
        var result = [Bool](repeating: false, count: 16)
        
        let midiData = track.getMIDINoteData()
        for midi in midiData {
            let position = Int(midi.position.beats * 4)
            result[position] = true
        }
        
        return result
    }
    
    public func start() {
        do {
            try engine.start()
        } catch {
            print("AudioEngine did not start! \(error)")
        }
        
        do {
            let files = samples.compactMap { $0.audioFile }
            try drums.loadAudioFiles(files)
        } catch {
            print("Files Didn't Load")
        }
        
        sequencer.clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
        sequencer.debug()
        sequencer.setGlobalMIDIOutput(drums.midiIn)
        sequencer.enableLooping(Duration(beats: Double(length/4)))

        sequencer.setTempo(120)
    }
    
    public func stop() {
        engine.stop()
    }
}
