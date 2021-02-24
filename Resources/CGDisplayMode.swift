//
//  CGDisplayMode.swift
//  Resolved
//
//  Created by Jayson Kish on 2/18/21.
//  Copyright © 2021 ToplessBanana. All rights reserved.
//

import Foundation

extension CGDisplayMode {
    
    static func getAvailableDisplayModes(for displayID: CGDirectDisplayID) -> [CGDisplayMode] {
        
        // Returns information about the currently available display modes.
        var availableDisplayModes = CGDisplayCopyAllDisplayModes(displayID, nil) as! [CGDisplayMode]
        
        // Sort the available display modes by width in decending order.
        for mode in availableDisplayModes {
            for index in 0 ..< availableDisplayModes.count {
                if mode.width < availableDisplayModes[index].width {
                    availableDisplayModes.remove(at: availableDisplayModes.firstIndex(of: mode)!)
                    availableDisplayModes.insert(mode, at: index)
                }
            }
        }
        
        return availableDisplayModes
        
    }
}
