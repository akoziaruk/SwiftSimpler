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
    private var engine = SimplerEngine()
    
    lazy var sampleCount = engine.samples.count
    lazy var sequenceLength = engine.length
    
    @Published var isPlaying = false {
        didSet {
            if isPlaying {
                engine.startPlay()
            } else {
                engine.stopPlay()
            }
        }
    }
    
    @Published var tempo: Float = 120 {
        didSet {
            engine.set(tempo: tempo)
        }
    }

    @Published var playbackPosition: Int = 0
    @Published var lockedSampleSequence: [Bool]!
    @Published var trackLockState = TrackLockState.none
    
    public func samplerPadPressed(index: Int) {
        if trackLockState == .locking {
            trackLockState = .locked(track: index)
            lockedSampleSequence = engine.getSequence(for: index)
        } else {
            engine.playPad(with: index)
        }
    }
    
    public func sequencerPadPressed(at index: Int) {
        guard case let .locked(sampleIndex) = trackLockState else {
            return
        }
        
        lockedSampleSequence[index].toggle()

        engine.updateSequencer(sampleIndex: sampleIndex,
                               position: index,
                               activate: lockedSampleSequence[index])
    }

    func start() {
        engine.start()
    }
    
    func stop() {
        engine.stop()
    }
    
    init() {
        engine.positionCallback = { [weak self] position in
            self?.playbackPosition = position
        }
    }

//    @objc
//    private func updatePosition() {
//        let newPosition = engine.playbackPosition()
//        if Int(newPosition) != playbackPosition {
//            playbackPosition = Int(ceil(newPosition))
//        }
//    }
}
