//
//  SequencerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.05.2022.
//

import SwiftUI

struct SequencerPadsView: View {
    @Binding var items: [Bool]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ForEach(0..<items.count, id: \.self) { index in
                    Rectangle()
                        .frame(height: 100)
                        .foregroundColor(items[index] ? .green : .green.opacity(0.6))
                        .onTapGesture {
                            items[index].toggle()
                        }
                }
            }
            Spacer()
        }
        .padding()
    }
}
