//
//  EffectPicker.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct EffectPickerView: View {
    @Binding var selected: Effect
    @State var effects: [Effect] = [.distortion, .delay, .reverb]
    @State var dragged: Effect?

    var body: some View {
        HStack {
            ForEach(effects, id: \.self) { effect in
                Button(effect.rawValue) {
                    selected = effect
                }
                .padding()
                .background(.red)
                .foregroundColor(.white)
                .onDrag({
                    dragged = effect
                    return NSItemProvider(object: effect.rawValue as NSString)
                })
                .onDrop(of: [UTType.text],
                        delegate: EffectsDropDelegate(item: effect, items: $effects, draggedItem: $dragged))
            }
            Spacer()
        }
        .padding()
    }

}
