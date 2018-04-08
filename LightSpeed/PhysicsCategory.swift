//
//  PhysicsCategory.swift
//  LightSpeed
//
//  Created by Ryan Shanks on 4/7/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let None      : Int = 0
    static let All       : Int = Int.max
    static let Orb       : Int = 0b1
    static let Ship      : Int = 0b10
}
