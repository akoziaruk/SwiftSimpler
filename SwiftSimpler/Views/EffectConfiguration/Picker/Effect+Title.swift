//
//  Effect+Title.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 13.07.2022.
//

import Foundation

extension EffectType {
    var title: String {
        switch self {
        case .distortion:   return "Distortion"
        case .delay:        return "Delay"
        case .reverb:       return "Reverb"
        case .equalizer:    return "EQ"
        case .flanger:      return "Flanger"
        case .cutoff:       return "Cutoff"
        }
    }
}
