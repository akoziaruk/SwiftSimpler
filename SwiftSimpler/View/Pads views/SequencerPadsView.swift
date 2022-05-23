//
//  SequencerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.05.2022.
//

import SwiftUI

struct SequencerPadsView: View {
    @Binding var items: [Velocity?]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<items.count, id: \.self) { index in
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor((items[index] != nil) ? .green : .green.opacity(0.6))
                        .onTapGesture {
                            if (items[index] != nil) {
                                items[index] = nil
                            } else {
                                items[index] = 127
                            }
                        }
                }
            }
            Spacer()
        }
        .padding()
    }
}
