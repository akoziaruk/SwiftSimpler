//
//  ControlButton.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct ControlButton: View {
    let text: String
    let action: ()->()
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
            
            Button {
                action()
            } label: {
                Text(text)
                    .font(.system(size: 50))
                    .minimumScaleFactor(0.8)
                    .padding(5)
            }
            .foregroundColor(Palette.yellow)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.yellow, lineWidth: 2)
        )
    }
}
