//
//  BPMTriangleButton.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 21.06.2022.
//

import SwiftUI

struct BPMTriangleButton: View {
    let action: ()->()

    var body: some View {
        TriangleShape()
            .stroke(Palette.yellow, style: StrokeStyle(lineWidth: 4, lineJoin: .round))
            .frame(width: 40)
            .onTapGesture {
                action()
            }
    }
}
