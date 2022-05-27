//
//  Node+Extentions.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 27.05.2022.
//

import AudioKit

extension Node {
    func updateBypass(_ bypass: Bool) {
        if bypass != !isStarted {
            if bypass {
                stop()
            } else {
                start()
            }
        }
    }
}
