//
//  PadsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct SamplePadsView_OLD: View {
    let padsCount: Int
    let didPressed: (Int) -> ()
        
    var body: some View {
        HStack {
            ForEach(0..<padsCount, id: \.self) { index in
                Pad_OLD {
                    didPressed(index)
                }
            }
        }
        .padding()
    }
}

struct Pad_OLD: View {
    @State var isSelected = false
    let didPressed: () -> ()
    
    var body: some View {
        Rectangle()
        .foregroundColor(isSelected ? .blue : .cyan)
        .gesture(DragGesture(minimumDistance: 0)
        .onChanged({ (touch) in
            if !isSelected {
                didPressed()
                isSelected = true
            }
        })
        .onEnded({ (touch) in
            isSelected = false
        }))
    }
}

