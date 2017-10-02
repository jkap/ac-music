//
//  PreferencesWindow.swift
//  ac-menubar
//
//  Created by jæ kaplan on 10/1/17.
//  Copyright © 2017 jae kaplan. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController, NSWindowDelegate {
    @IBOutlet weak var gameSelect: NSPopUpButton!
    
    var delegate: PreferencesWindowDelegate?
    
    override var windowNibName: NSNib.Name? {
        return NSNib.Name.init("PreferencesWindow")
    }
    
    @IBAction func gameSelectionChanged(_ sender: NSPopUpButton) {
        let defaults = UserDefaults.standard
        defaults.setValue(gameSelect.selectedItem?.title, forKey: "game")
        delegate?.preferencesDidUpdate()
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        
        let defaults = UserDefaults.standard
        let game = defaults.string(forKey: "game")
        let gameList = defaults.array(forKey: "gameList") as! [String]
        self.gameSelect.addItems(withTitles: gameList)
        gameSelect.selectItem(withTitle: game!)
        
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func windowWillClose(_ notification: Notification) {
    }
}

protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}
