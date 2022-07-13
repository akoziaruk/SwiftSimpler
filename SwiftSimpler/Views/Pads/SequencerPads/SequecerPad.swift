//
//  SequecerPad.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 11.07.2022.
//

import SwiftUI

//TODO: Add press force depending velocity
struct SequecerPad: View {
    @Binding var selected: Velocity?
    
    var accent: Bool
    var onStep: Bool
    
    var body: some View {
        ZStack {
            // Border
            RoundedRectangle(cornerRadius: 12)
                .stroke(accent ? Palette.grey : Palette.greyLightOne , lineWidth: 2)
            
            // Selection
            if selected != nil {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Palette.redLight)
            }
            
            // On step occurence
            if onStep {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(Palette.yellowLightTwo)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selected = selected == nil ? Velocity.max: nil
        }
        
    }
}
