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

    private var orbsInFront:[LightOrb] = []
    private var orbsBehind: [LightOrb] = []
    private var orbsPassed = 0
    private var ship:SpaceShip
    private var timeOfLastUpdate:TimeInterval = 0
    var controls: ControlOverlay? = nil
    
    private var scene:SCNScene
    init(_ scene: SCNScene){
        self.scene = scene
        ship = SpaceShip()
        ship.scale = SCNVector3(x:0.5, y:0.5,z:0.5)
        scene.rootNode.addChildNode(ship)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval){
        if (Double(orbsInFront.count) < sqrt(Double(orbsPassed)) || orbsPassed == 0 && orbsInFront.count == 0){
            // need to create another orb
            let orb = LightOrb(orbsPassed: orbsPassed)
            scene.rootNode.addChildNode(orb)
            orbsInFront.append(orb)
        }
        if (orbsInFront.count > 0){
            //check for orbs which have passed the ship
            for i in stride(from: orbsInFront.count-1, through: 0, by:-1){
                if orbsInFront[i].hasPassed() {
                    orbsPassed += 1
                    controls?.setOrbsPassed(orbsPassed)
                    // move the orb to orbsBehind
                    let orb = orbsInFront.remove(at: i)
                    orbsBehind.append(orb)
                }
            }
            //check for orbs which are far enough past the ship to be deleted
            for i in stride(from: orbsBehind.count-1, through: 0, by:-1){
                if orbsBehind[i].hasFinishedTravel() {
                    orbsBehind[i].removeFromParentNode()
                    orbsBehind.remove(at: i)
                    print("removing orb")
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
