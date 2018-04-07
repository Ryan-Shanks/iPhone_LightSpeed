//
//  GameLogic.swift
//  LightSpeed
//
//  Created by user136098 on 4/5/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit

struct ArrowKeys{
    static let UP:UInt8 = 0b1
    static let DOWN:UInt8 = 0b10
    static let LEFT:UInt8 = 0b100
    static let RIGHT:UInt8 = 0b1000
    
    static let VERT:UInt8 = UP|DOWN
    static let HORIZ:UInt8 = RIGHT|LEFT
}
class GameLogic:NSObject, SCNSceneRendererDelegate {

    private var orbs:[LightOrb] = []
    private var orbsPassed = 0
    private var ship:SpaceShip
    private var timeOfLastUpdate:TimeInterval = 0
    
    private var scene:SCNScene
    init(_ scene: SCNScene){
        self.scene = scene
        ship = SpaceShip()
        ship.scale = SCNVector3(x:0.5, y:0.5,z:0.5)
        scene.rootNode.addChildNode(ship)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
        if (Double(orbs.count) < sqrt(Double(orbsPassed)) || orbsPassed == 0 && orbs.count == 0){
            // need to create another orb
            let orb = LightOrb(orbsPassed: orbsPassed)
            scene.rootNode.addChildNode(orb)
            orbs.append(orb)
        }
        if (orbs.count > 0){
            for i in stride(from: orbs.count-1, through: 0, by:-1){
                if orbs[i].hasPassed() {
                    orbs[i].removeFromParentNode()
                    orbs.remove(at: i)
                    orbsPassed += 1
                    print("orbsPassed: " , orbsPassed)
                }
            }
        }
        //so the ship can fly smoothly if the user is still holding the button
        if timeOfLastUpdate != 0 {
            ship.tick(elapsed: time - timeOfLastUpdate)
        }
        timeOfLastUpdate = time
    }
    func handleKeys(_ keysPressed:UInt8){
        ship.setKeysDown(keysPressed)
    }
}
