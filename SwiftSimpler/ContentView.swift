//
//  ContentView.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 05.05.2022.
//

import SwiftUI

//struct ContentView: View {
//    @StateObject var conductor = SequencerConductor()
//    @State var seqencerMode = false
//
//    var body: some View {
//        VStack() {
//            Spacer()
////            TitleView()
//            Spacer()
//            if seqencerMode {
////                SequencerPads(items: $conductor.kicks)
//            } else {
////                LivePads(play: $conductor.playKick, count: $conductor.kicks.count)
//            }
//            Spacer()
////            ControlButtonsView(isPlaying: $conductor.isPlaying, seqencerMode: $seqencerMode)
//            Spacer()
//        }
//        .onAppear {
//            self.conductor.start()
//        }
//        .onDisappear {
//            self.conductor.stop()
//        }
//    }
//}
//
//struct LivePads: View {
//    @Binding var play: Bool
//    let count: Int
//    
//    var body: some View {
//        HStack() {
//            ForEach(0..<count, id: \.self) { index in
//                Rectangle().onTapGesture {
//                    play.toggle()
//                }
//                .frame(width: 50, height: 50)
//                .foregroundColor(.purple)
//            }
//        }
//        .padding()
//        .background(.gray)
//    }
//}

//struct SequencerPads: View {
//    @Binding var items: [Bool]
//    
//    var body: some View {
//        HStack() {
//            ForEach(0..<items.count, id: \.self) { index in
//                Pad(isSelected: $items[index]).onTapGesture {
//                    items[index].toggle()
//                }
//            }
//        }
//        .padding()
//        .background(.gray)
//    }
//}

//struct Pad: View {
//    @Binding var isSelected: Bool
//    
//    var body: some View {
//        Rectangle()
//        .frame(width: 50, height: 50)
//        .foregroundColor(isSelected ? .blue : .cyan)
//    }
//}

//struct ControlButtonsView: View {
//    @Binding var isPlaying: Bool
//    @Binding var seqencerMode: Bool
//
//    var body: some View {
//        HStack {
//            Button(isPlaying ? "Stop" : "Play") {
//                isPlaying.toggle()
//            }
//            .frame(width: 100, height: 100, alignment: .center)
//            .background(.purple)
//            .foregroundColor(.white)
//
//            Button(seqencerMode ? "Tappable": "Sequence") {
//                seqencerMode.toggle()
//            }
//            .frame(width: 100, height: 100, alignment: .center)
//            .background(.yellow)
//            .foregroundColor(.white)
//
//            Spacer()
//        }.padding()
//    }
//}

//struct TitleView: View {
//    var body: some View {
//        Text("SIMPLER")
//            .font(Font.system(.largeTitle))
//            .foregroundColor(.blue)
//            .padding()
//    }
//}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
