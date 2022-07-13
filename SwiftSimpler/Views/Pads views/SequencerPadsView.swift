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
                HStack(spacing: 0) {
                    let offset = page * 16
                    ForEach(offset..<offset+16, id: \.self) { index in
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
            }
        }
        .padding()
    }
}
