//
//  StatusMenuController.swift
//  ac-menubar
//
//  Created by jæ kaplan on 9/24/17.
//  Copyright © 2017 jae kaplan. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject, PreferencesWindowDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var timeItem: NSMenuItem!
    var weatherMenuItem: NSMenuItem!
    var preferencesWindow: PreferencesWindow!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let audioPlayer = AudioPlayer()
    var hourChangeTimer: Timer!
    
    override func awakeFromNib() {
        let icon = NSImage(named: NSImage.Name("statusIcon"))
        icon?.isTemplate = true
        statusItem.button?.image = icon
        statusItem.menu = statusMenu
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
        hourHasChanged()
    }
    
    func setPlayPauseTitle(playing: Bool) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        self.timeItem.title = "\(playing ? "⏸" : "▶️") \(dateFormatter.string(from: Date()))"
    }
    
    func hourHasChanged() {
        self.audioPlayer.date = Date()
        self.audioPlayer.play()
        
        self.setPlayPauseTitle(playing: self.audioPlayer.isPlaying())
                
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.minute], from: Date())
        let minutesRemaining = 60 - comp.minute!
        let interval = TimeInterval.init(60 * minutesRemaining)
        let fireTime = Date.init(timeIntervalSinceNow: interval)
        
        if self.hourChangeTimer != nil {
            self.hourChangeTimer.invalidate()
        }
        self.hourChangeTimer = Timer.init(fire: fireTime, interval: interval, repeats: false, block: { timer in
            print("TIMER TIMER TIMER")
            self.hourHasChanged()
        })
        RunLoop.current.add(self.hourChangeTimer, forMode: .commonModes)
        print(fireTime)
    }
    
    func preferencesDidUpdate() {
        hourHasChanged()
    }
    
    @IBAction func playPauseClicked(_ sender: NSMenuItem) {
        self.audioPlayer.toggle()
        self.setPlayPauseTitle(playing: self.audioPlayer.isPlaying())
    }
    
    @IBAction func preferencesClicked(_ sender: Any) {
        self.preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
