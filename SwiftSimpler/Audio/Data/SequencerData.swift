//
//  SequencerData.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.07.2022.
//

import Foundation

typealias Sequence = [Velocity?]

struct SequenceData {
    var one:    Sequence
    var two:    Sequence
    var three:  Sequence
    var four:   Sequence

    init() {
        one =   Sequence(repeating: nil, count: 16)
        two =   Sequence(repeating: nil, count: 16)
        three = Sequence(repeating: nil, count: 16)
        four =  Sequence(repeating: nil, count: 16)
    }
}

extension SequenceData {
    func combined() -> Sequence {
        return one + two + three + four
    }
}
