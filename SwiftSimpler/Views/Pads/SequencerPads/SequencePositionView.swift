//
//  SequencePositionView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 04.07.2022.
//

import SwiftUI

struct SequencePositionView: View {
    @Binding var length: Int
    
    let page: Int
    let spacing: CGFloat
    
    var body: some View {
        ZStack {
                    
            // Border
            GeometryReader { context in
                Rectangle()
                    .frame(height: borderHeight(for: context.size.height))
                    .foregroundColor(.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Palette.grey, lineWidth: 2)
                    )
            }
            
            // Indication
            VStack(spacing: spacing) {
                ForEach(1...4, id: \.self) { index in
              
                    VStack(spacing: 0) {
                        Spacer()
                        
                        Rectangle()
                            .frame(height: 5)
                            .foregroundColor(.clear)
                    
                        Text("\(index)")
                            .font(.system(size: 30))
                            .foregroundColor(Palette.white)

                        Rectangle()
                            .frame(height: 5)
                            .foregroundColor((index-1 == page) ? Palette.white: .clear)
                        
                        Spacer()
                        
                    }
                    .onTapGesture {
                        length = index
                    }
                }
            }
        }
    }
    
    func borderHeight(for maxSize: CGFloat) -> CGFloat {
        let totalMargin = 3 * spacing
        let itemHeight = ((maxSize - totalMargin) / 4 * CGFloat(length))
        let marginOffset = spacing * CGFloat((length - 1))
        return itemHeight + marginOffset
    }
    
}
