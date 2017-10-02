//
//  AppDelegate.swift
//  ac-menubar
//
//  Created by jæ kaplan on 9/24/17.
//  Copyright © 2017 jae kaplan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let defaultPrefsFile = Bundle.main.url(forResource: "DefaultPreferences", withExtension: "plist"),
            let data = try? Data(contentsOf: defaultPrefsFile) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                UserDefaults.standard.register(defaults: result!)
            }
        }
            
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

