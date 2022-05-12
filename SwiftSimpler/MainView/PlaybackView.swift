//
//  PlaybackView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 12.05.2022.
//

import SwiftUI

struct PlaybackView: View {
    @Binding var position: Int
    var segments: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(.gray.opacity(0.3))
                
                let width = geometry.size.width/CGFloat(segments)
                PlaybackCursor(width: width,
                               position: position)
            }
            .padding()
        }
    }
}

struct PlaybackCursor: View {
    var width: CGFloat
    var position: Int
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 10)
            .foregroundColor(.brown)
            .offset(x: width*CGFloat(position), y: 0)
    }
}
