//
//  SequencerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.05.2022.
//

import SwiftUI

struct SequencerPadsView: View {
    @Binding var sequence: Sequence
    var page: Int
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(0..<sequence.count, id: \.self) { index in
                            Rectangle()
                                .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                .frame(width: reader.size.width / 16, height: 100)
                                .foregroundColor((sequence[index] != nil) ? .blue :
                                                 ((index % 4 == 0 ) ? .green.opacity(0.8) : .green.opacity(0.6)))
                                .onTapGesture {
                                    sequence[index] = (sequence[index] == nil) ? Velocity(127) : nil
                                }
                        }
                    }
                    .offset(x: -CGFloat(page) * reader.size.width, y: 0)
                }
            }
        }
        .padding()
    }
}
