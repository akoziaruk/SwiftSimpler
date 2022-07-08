//
//  TrackButton.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 08.07.2022.
//

import SwiftUI

struct TrackButton: View {
    @Binding var active: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(active ? Palette.redLight: .clear)
            
            ControlButton(text: "TRK") {
                active.toggle()
            }
        }
    }
}
