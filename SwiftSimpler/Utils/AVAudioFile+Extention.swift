//
//  AVAudioFile+Extention.swift
//  SwiftSimpler
//
//  Created by Alexander Koziaruk on 09.05.2022.
//

import AVFAudio

extension AVAudioFile {
    static func audioFile(with fileName: String) -> AVAudioFile? {
        guard let url = Bundle.main.resourceURL?.appendingPathComponent("Samples/\(fileName)") else {
            return nil
        }
        do {
            return try AVAudioFile(forReading: url)
        } catch {
            print("Failed to load audiofile: \(fileName)")
        }
        return nil
    }
}
