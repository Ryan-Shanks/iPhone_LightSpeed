//
//  ControlsOverlay.swift
//  LightSpeed
//
//  Created by user136098 on 4/6/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
class ControlOverlay: SKScene {
    private var game: GameLogic
    init(_ game: GameLogic) {
        self.game = game
        super.init()
        
        // Add the arrows
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
