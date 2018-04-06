//
//  GameLogic.swift
//  LightSpeed
//
//  Created by user136098 on 4/5/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit
class GameLogic:NSObject, SCNSceneRendererDelegate {
    private var orbs:[LightOrb] = []
    private var orbsPassed = 0
    
    private var scene:SCNScene
    init(_ scene: SCNScene){
        self.scene = scene
        let ship = SpaceShip()
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
    }
}
