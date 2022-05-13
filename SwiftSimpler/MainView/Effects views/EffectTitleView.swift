//
//  EffectTitleView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct EffectTitleView: View {
    var title: String
    var body: some View {
        HStack{
            Text(title)
                .font(Font.system(.largeTitle))
                .foregroundColor(.blue)
                .padding()
                .border(.cyan, width: 2)
            Spacer()
        }
        .padding()
    }
}
