//
//  TitleView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        Text("SIMPLER")
            .font(Font.system(.largeTitle))
            .foregroundColor(.blue)
            .padding()
            .border(.cyan, width: 2)
            .frame(width: nil, height: 250)
    }
}
