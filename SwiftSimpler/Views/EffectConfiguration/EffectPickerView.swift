//
//  EffectPickerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 14.06.2022.
//

import SwiftUI

struct EffectPickerView: View {
    @Binding var selected: EffectType
    @Binding var all: [EffectType]

    var body: some View {
        HStack(spacing: 20) {
            ForEach(all, id: \.self) { effect in
                    Button {
                        selected = effect
                    } label: {
                        Text(effect.title)
                            .foregroundColor(Palette.white)
                            .font(.title3)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                    }
                    .frame(maxHeight: .infinity)
                    .padding([.trailing, .leading], 18)
                    .background((selected == effect) ? Palette.black: .clear)
                    .overlay(
                        OpenEdgeRoundedRect(openEdge: .top)
                            .strokeBorder(Palette.red, lineWidth: (selected == effect) ? 2 : 1)
                    )
            }
            Spacer()
        }
        .padding(.leading, 30)
    }
}
