//
//  AudioPlayer.swift
//  ac-menubar
//
//  Created by jæ kaplan on 10/1/17.
//  Copyright © 2017 jae kaplan. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    private var audioPlayer: AVAudioPlayer!
    private var _date: Date!
    var date: Date! {
        get {
            return self._date
        }
        
        set(newDate) {
            self._date = newDate
            self.audioPlayer?.stop()
            self.audioPlayer = createAudioPlayer(newDate)
        }
    }
    
    init(date: Date = Date()) {
        self.date = date
    }
    
    private func getGame() -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "game")
    }
    
    private func createAudioPlayer(_ time: Date) -> AVAudioPlayer? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        let baseFile = dateFormatter.string(from: time).lowercased()
        let filePath = Bundle.main.path(forResource: baseFile, ofType: "mp3", inDirectory: self.getGame())
        print(filePath as Any)
        if filePath == nil {
            return nil
        }
        let audioPlayer = try! AVAudioPlayer.init(contentsOf: URL(fileURLWithPath: filePath!))
        audioPlayer.numberOfLoops = Int.max
        return audioPlayer
    }
    
    func play() {
        self.audioPlayer?.play()
    }
    
    func stop() {
        self.audioPlayer?.stop()
    }
    
    func toggle() {
        self.isPlaying() ? self.stop() : self.play()
    }
    
    func isPlaying() -> Bool {
        if self.audioPlayer != nil {
            return self.audioPlayer.isPlaying
        }
        return false
    }
}
