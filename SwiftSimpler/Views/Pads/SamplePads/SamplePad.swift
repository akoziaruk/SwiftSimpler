//
//  SamplePad.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct SamplePad: View {
    @State var isSelected = false
    
    var active: Bool
    var didPressed: ()->()

    var color: Color {
        if isSelected       { return Palette.yellowLightTwo }
        else if active      { return Palette.redLight       }
        else                { return .clear }
    }
    
    var body: some View {
        ZStack {
            // Border
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.grey, lineWidth: 2)
            
            // Selection
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(color)
        }
        .contentShape(Rectangle())
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged({ (touch) in
                if !isSelected {
                    didPressed()
                    isSelected = true
                }
            })
            .onEnded({ (touch) in
                isSelected = false
            })
        )
    }
}
