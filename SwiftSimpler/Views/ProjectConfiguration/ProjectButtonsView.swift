//
//  ProjectButtonsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 10.06.2022.
//

import SwiftUI

struct ProjectButtonsView: View {
    @State private var showingAlert = false

    var body: some View {
        VStack() {
            Button("🥁") {
                showingAlert = true
            }
            .font(Font.system(size: 30))
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 4))
            .overlay(
                OpenEdgeRoundedRect(openEdge: .trailing)
                    .stroke(Palette.grey)
            )
            .offset(x: 2)
            .alert("Feature not implemented", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            
            Spacer()
        }
        .padding(.top, 10)
    }
}
