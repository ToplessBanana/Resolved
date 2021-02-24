//
//  String.swift
//  ResolvedCLI
//
//  Created by Jayson Kish on 2/18/21.
//  Copyright © 2021 ToplessBanana. All rights reserved.
//

import Foundation

extension String {
    var padded: String {
        return self.padding(toLength: 10, withPad: " ", startingAt: 0)
    }
}
