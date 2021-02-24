//
//  AppDelegate.swift
//  Resolved
//
//  Created by Jayson Kish on 2/18/21.
//  Copyright © 2021 ToplessBanana. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    // MARK: Declarations

    // Returns a newly created status item that has been allotted a specified space within the status bar.
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    // An object that manages an app's menus.
    let menu = NSMenu()
    
    // Returns the display ID of the main display.
    let mainDisplayID = CGMainDisplayID()
    
    // Returns information about the display’s current configuration.
    let usersOriginalDisplayMode = CGDisplayCopyDisplayMode(CGMainDisplayID())
    
    // An array of available display mode objects.
    var displayModes: [CGDisplayMode] = []
    
    // MARK: Methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        if let button = statusItem.button {
            button.title = "􀒶"
            statusItem.behavior = .terminationOnRemoval
            statusItem.menu = menu
            statusItem.isVisible = true
        }
        
        displayModes = CGDisplayMode.getAvailableDisplayModes(for: mainDisplayID)
        populate(menu, with: displayModes)
        
    }
    
    func populate(_ menu: NSMenu, with displayModes: [CGDisplayMode]) {
        
        var tag = 0

        for mode in displayModes {
            let name = "\(mode.width) x \(mode.height)"
            let menuItem = NSMenuItem(title: name, action: #selector(setDisplayMode), keyEquivalent: "")
            menuItem.target = self
            menuItem.tag = tag
            menu.addItem(menuItem)
            tag = tag + 1
        }
        
        let name = "Revert to Original Mode"
        let menuItem = NSMenuItem(title: name, action: #selector(setDisplayMode), keyEquivalent: "")
        menuItem.target = self
        menu.addItem(NSMenuItem.separator())
        menu.addItem(menuItem)
        
    }
    
    @objc func setDisplayMode(_ item: NSMenuItem) {
        if item.title == "Revert to Original Mode" {
            CGDisplaySetDisplayMode(mainDisplayID, usersOriginalDisplayMode, nil)
        } else {
            CGDisplaySetDisplayMode(mainDisplayID, displayModes[item.tag], nil)
        }
    }
    
}
