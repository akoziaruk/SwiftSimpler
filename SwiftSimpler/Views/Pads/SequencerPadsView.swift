//
//  SequencerPadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.07.2022.
//

import SwiftUI

struct SequencerPadsView: View {
    @Binding var sequence: SequenceData
    
    var playbackData: PlaybackData

    var body: some View {
        VStack {
            SequenceLineView(sequence: $sequence.one,   active: playbackData.length >= 1, step: step(row: 1))
            SequenceLineView(sequence: $sequence.two,   active: playbackData.length >= 2, step: step(row: 2))
            SequenceLineView(sequence: $sequence.three, active: playbackData.length >= 3, step: step(row: 3))
            SequenceLineView(sequence: $sequence.four,  active: playbackData.length >= 4, step: step(row: 4))
        }
    }
    
    func step(row: Int) -> Int? {
        if !playbackData.isPlaying { return nil }
        
        let min = (row - 1) * 16
        let max = min + 16
        
        if playbackData.position >= min && playbackData.position < max {
            return playbackData.position % 16
        }
        return nil
    }
}
