//
//  SimplerView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import SwiftUI

struct SimplerView: View {
    @StateObject var conductor = SequencerConductor()
    
    var body: some View {
        VStack {
            TitleView()
            ControlButtonsView(isPlaying: $conductor.isPlaying, trackLockState: $conductor.trackLockState)
            if conductor.trackLockState.notLocked() {
                PadsView(padsCount: conductor.sampleCount) { conductor.samplerPadPressed(index: $0) }
            } else {
                SequencerView(items: $conductor.lockedSampleSequence) { conductor.sequencerPadPressed(at: $0) }
            }
            PlaybackView(position: conductor.playbackPosition, segments: conductor.sequenceLength)
        }
        .onAppear {
            self.conductor.start()
        }
        .onDisappear {
            self.conductor.stop()
        }
    }
}

struct PlaybackView: View {
    var position: Int
    var segments: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 10)
                    .foregroundColor(.gray.opacity(0.3))
                
                PlaybackCursor(width: geometry.size.width/CGFloat(segments),
                               position: position)
            }
            .padding()
        }

    }
}

struct PlaybackCursor: View {
    var width: CGFloat
    var position: Int
    
    var body: some View {
        Rectangle()
            .frame(width: width, height: 10)
            .foregroundColor(.brown)
            .offset(x: width*CGFloat(position), y: 0)
    }
}



struct SimplerView_Previews: PreviewProvider {
    static var previews: some View {
        SimplerView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
