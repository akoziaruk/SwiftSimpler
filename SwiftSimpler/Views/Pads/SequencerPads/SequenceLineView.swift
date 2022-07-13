//
//  SequenceLineView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.07.2022.
//

import SwiftUI

struct SequenceLineView: View {
    @Binding var sequence: Sequence
    
    var active: Bool
    var step: Int?
    
    var body: some View {
        HStack {
            ForEach(0..<sequence.count, id: \.self) { index in
                SequecerPad(selected: $sequence[index],
                            accent: index%4 == 0,
                            onStep: step == index)
            }
        }
        .opacity(active ? 1 : 0.3)
    }
}
