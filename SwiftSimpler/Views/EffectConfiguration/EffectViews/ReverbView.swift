//
//  ReverbView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 14.06.2022.
//

import SwiftUI

struct ReverbView: View {
    let itemWidth: CGFloat
    
    let items = ["Mix", "Crossover", "Damping", "Predelay", "Rls low", "Rls mid"]
    
    var body: some View {
        HStack(spacing: 20) {
            
            ForEach(items,  id: \.self) { item in
                KnobSegment(title: item)
                    .frame(width: itemWidth)
            }

            Spacer()
        }
        .lineLimit(1)
        .padding(20)
    }
}
