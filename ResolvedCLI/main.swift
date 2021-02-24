//
//  main.swift
//  ResolvedCLI
//
//  Created by Jayson Kish on 2/18/21.
//  Copyright © 2021 ToplessBanana. All rights reserved.
//

import Foundation
import ArgumentParser

struct ResolvedCLI: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for switching between display modes.",
        version: "1.2.1",
        subcommands: [List.self, Set.self],
        defaultSubcommand: Set.self)
}

extension ResolvedCLI {
    
    // MARK: Subcommand
    
    struct List: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "List available display modes.")
        
        func run() {
            let availableDisplayModes = CGDisplayMode.getAvailableDisplayModes(for: CGMainDisplayID())
            
            print("MODE".padded, "WIDTH".padded, "HEIGHT".padded)
            
            var index = 0
            
            for mode in availableDisplayModes {
                print("\(index):".padded, "\(mode.width)".padded, "\(mode.height)".padded)
                index = index + 1
            }
        }
    }
    
    // MARK: Subcommand
    
    struct Set: ParsableCommand {
        static var configuration = CommandConfiguration(abstract: "Set the display mode.")
        
        @Argument(help: "Index of the display mode.")
        var mode: Int
        
        @Flag(help: "Change mode only for current session.")
        var sessionOnly: Bool = false

        func run() {
            let availableDisplayModes = CGDisplayMode.getAvailableDisplayModes(for: CGMainDisplayID())
            
            // A reference to a display configuration transaction.
            var configuration: CGDisplayConfigRef?
            
            if mode < availableDisplayModes.count {
                
                // Begins a new set of display configuration changes.
                CGBeginDisplayConfiguration(&configuration)
                
                // Configures the display mode of a display.
                CGConfigureDisplayWithDisplayMode(configuration, CGMainDisplayID(), availableDisplayModes[mode], nil)
                
                // Completes a set of display configuration changes.
                if !sessionOnly {
                    CGCompleteDisplayConfiguration(configuration, .permanently)
                } else {
                    CGCompleteDisplayConfiguration(configuration, .forSession)
                }
                
            } else {
                print("Error: The value '\(mode)' is invalid for '<mode>'")
            }
        }
    }
}

ResolvedCLI.main()
