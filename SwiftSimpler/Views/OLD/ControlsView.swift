//
//  ControlButtonsView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var conductor: Conductor
    
    @Binding var trackLockState: TrackLockState

    var body: some View {
        HStack {
            Button(conductor.playbackData.isPlaying ? "STOP" : "PLAY") {
                conductor.playbackData.isPlaying.toggle()
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(.purple)
            .foregroundColor(.white)
            .padding()

            TextField("120", value: $conductor.playbackData.tempo, formatter: NumberFormatter())
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 100, height: 100, alignment: .center)
            .background(.green)
            .foregroundColor(.white)
            .padding()

            Spacer()
            
//            BeatPageSelector(selected: $conductor.data.playback.length, page: $conductor.data.playback.page)
            
            Button("TRACK") {
                trackLockState.toggleTap()
            }
            .frame(width: 100, height: 100, alignment: .center)
            .background(trackLockState == .none ? .yellow: .yellow.opacity(0.5))
            .foregroundColor(.white)
            .background(trackLockState == .locking ? .red: .clear)
            .padding()
        }
    }
}

struct BeatPageSelector: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @Binding var selected: Int
    @Binding var page: Int
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(1...4, id: \.self) { item in
                Text("\(item)")
                    .frame(width: 48, height: 48)
                    .background(item <= selected ? .brown.opacity(0.7) : .brown.opacity(0.25))
                    .border(item == page+1 ? .purple : .clear, width: 4)
                    .onTapGesture {
                        page = item-1
                    }
                    .onLongPressGesture(perform: {
                        selected = item
                    })
            }
        }
        .frame(width: 100, height: 100, alignment: .center)
        .padding()
    }
    
}
