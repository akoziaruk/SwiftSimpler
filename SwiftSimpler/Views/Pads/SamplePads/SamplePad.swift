//
//  SamplePad.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct SamplePad: View {
    @State var isSelected = false

    var didPressed: ()->()

    var body: some View {
        ZStack {
            // Border
            RoundedRectangle(cornerRadius: 12)
                .stroke(Palette.grey, lineWidth: 2)
            
            // Selection
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor((isSelected ? Palette.redLight : .clear))
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
