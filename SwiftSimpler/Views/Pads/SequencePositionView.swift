//
//  SequencePositionView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 04.07.2022.
//

import SwiftUI

struct SequencePositionView: View {
    let size = 2
    
    var body: some View {
        ZStack {
            
            // Border
            GeometryReader { context in
                Rectangle()
                    .frame(height: context.size.height / 4 * CGFloat(size))
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Palette.grey, lineWidth: 2)
                    )
            }
            
            // Indication
            VStack {
                ForEach(1...4, id: \.self) { index in
                    Spacer()
                    
                    Text("\(index)")
                        .font(.system(size: 30))
                        .foregroundColor(Palette.white)
                    
                    Spacer()
                }
            }
            .frame(maxHeight: .infinity)
        
        }
    }
}
