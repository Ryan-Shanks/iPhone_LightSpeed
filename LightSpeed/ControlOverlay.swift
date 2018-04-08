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
    var touches:[UITouch: UInt8] = [:]
    
    //Update the score based on how many orbs have passed, called by game logic whenever one does pass
    func setOrbsPassed(_ passed:Int) {
        (childNode(withName: "orbsPassed") as! SKLabelNode).text = "Score: " + String(passed)
    }
    
    //Convert the nodes name to one of the ArrowKeys options, or 0 for none
    private func buttonStringToInt(_ buttonName:String?) -> UInt8{
        switch (buttonName) {
        case "upButton"?:
            return ArrowKeys.UP
        case "downButton"?:
            return ArrowKeys.DOWN
        case "leftButton"?:
            return ArrowKeys.LEFT
        case "rightButton"?:
            return ArrowKeys.RIGHT
        default:
            return 0
        }
    }
    //collect the result of all the touches
    private func allKeysToInt() -> UInt8 {
        var res:UInt8 = 0
        for v in touches.values{
            res |= v
        }
        return res
    }
    //Start tracking new touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: UITouch in touches {
            let location = touch.location(in:self)
            let theNode = self.atPoint(location)
            let num = buttonStringToInt(theNode.name)
            self.touches[touch] = num // new touch occured, store in the map for now
        }
        game?.handleKeys(allKeysToInt())
    }
    //Touches can move between buttons or out of buttons, and we should keep track of that
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            // if a touch moved, need to check if its still on the button or not
        for touch:UITouch in touches {
            let location = touch.location(in: self)
            let theNode = self.atPoint(location)
            self.touches[touch] = buttonStringToInt(theNode.name)
        }
        game?.handleKeys(allKeysToInt())
    }
    //remove touches when the user lifts their finger
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:UITouch in touches {
            self.touches.removeValue(forKey: touch)
        }
        game?.handleKeys(allKeysToInt())
    }
    //same as above
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:UITouch in touches {
            self.touches.removeValue(forKey: touch)
        }
    }
}
