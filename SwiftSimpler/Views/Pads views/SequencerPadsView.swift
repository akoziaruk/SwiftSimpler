//
//  SequencerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.05.2022.
//

import SwiftUI

struct SequencerPadsView: View {
    @Binding var sequence: Sequence
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<sequence.count, id: \.self) { index in
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor((sequence[index] != nil) ? .green : .green.opacity(0.6))
                        .onTapGesture {
                            sequence[index] = (sequence[index] == nil) ? Velocity(127) : nil
                        }
                }
            }
            Spacer()
        }
        .padding()
    }
}
