//
//  SequencerPadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.07.2022.
//

import SwiftUI

struct SequencerPadsView: View {
    @Binding var sequence: SequenceData
    
    var position: Int
    var length: Int

    var body: some View {
        VStack {
            SequenceLineView(sequence: $sequence.one,   active: length >= 1, step: step(row: 1))
            SequenceLineView(sequence: $sequence.two,   active: length >= 2, step: step(row: 2))
            SequenceLineView(sequence: $sequence.three, active: length >= 3, step: step(row: 3))
            SequenceLineView(sequence: $sequence.four,  active: length >= 4, step: step(row: 4))
        }
    }
    
    func step(row: Int) -> Int? {
        let min = (row - 1) * 16
        let max = min + 16
        
        if position >= min && position < max {
            return position % 16
        }
        return nil
    }
}
