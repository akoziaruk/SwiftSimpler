//
//  EffectPicker.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.05.2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct EffectPickerView_OLD: View {
    @Binding var selected: EffectType
    @Binding var all: [EffectType]
    @State var dragged: EffectType?

    var body: some View {
        HStack {
            ForEach(all, id: \.self) { effect in
                Button(effect.title) {
                    selected = effect
                }
                .padding()
                .background(effect == selected ? .red : .red.opacity(0.8))
                .foregroundColor(.white)
                .onDrag({
                    dragged = effect
                    return NSItemProvider(object: effect.title as NSString)
                })
                .onDrop(of: [UTType.text],
                        delegate: EffectsDropDelegate(item: effect, items: $all, draggedItem: $dragged))
            }
            Spacer()
        }
        .padding()
    }
}
