//
//  Data.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 25.05.2022.
//

import Foundation

struct Data {
    var playback = Playback()
    var isPlaying = false
    var tempo: Double = 120
    
    struct Playback {
        var page = 0
        var length = 1
    }
}
