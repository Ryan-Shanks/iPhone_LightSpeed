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
    var game:GameLogic? = nil

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in:self)
            let theNode = self.atPoint(location)
            if theNode.name == "upButton"{
                
            } else if theNode.name == "downButton" {
                
            } else if theNode.name == "rightButton"{
                
            } else if theNode.name == "leftButton"{
                
            }
        }
    }
}
