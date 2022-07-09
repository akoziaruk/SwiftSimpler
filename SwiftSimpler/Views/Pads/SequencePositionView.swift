//
//  SequencePositionView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 04.07.2022.
//

import SwiftUI

struct SequencePositionView: View {
    @Binding var length: Int
    
    let position: Int
    
    var body: some View {
        ZStack {
            
            // Border
            GeometryReader { context in
                Rectangle()
                    .frame(height: context.size.height / 4 * CGFloat(length))
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Palette.grey, lineWidth: 2)
                    )
            }
            
            // Indication
            VStack(spacing: 0) {
                ForEach(1...4, id: \.self) { index in
                    Spacer()
                    
                    Text("\(index)")
                        .font(.system(size: 30))
                        .foregroundColor(Palette.white)
                    
                    Rectangle()
                        .frame(height: 5)
                        .foregroundColor((index-1 == position) ? Palette.white: .clear)
                    
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
        
        }
    }
}
