//
//  EffectPicker.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI

struct EffectPickerView: View {
    @Binding var activeEffect: ActiveEffect
    var body: some View {
        HStack {
            Button("Distortion") {
                activeEffect = .distortion
            }.padding()
            Button("Reverb") {
                activeEffect = .reverb
            } .padding()
            Button("Delay") {
                activeEffect = .delay
            }.padding()
            Spacer()
        }
        .padding()
    }
}
