//
//  LightOrb.swift
//  LightSpeed
//
//  Created by user136098 on 3/27/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit
import UIKit
class LightOrb: SCNNode {
    
    var finished = false
    static let colorOptions:[UIColor] = [.red, .blue, .yellow, .green, .cyan, .orange]
    
    init(orbsPassed: Int){
        super.init()
        let sphere = SCNSphere(radius: 1.0)
        geometry = sphere
        sphere.firstMaterial?.lightingModel = .phong
        let colour = LightOrb.colorOptions[Int(randBetween(0.0, Float(LightOrb.colorOptions.count-1)))]
        sphere.firstMaterial?.emission.contents = colour
        sphere.firstMaterial?.ambient.contents = colour
        sphere.firstMaterial?.diffuse.contents = colour
        
        position.x = randBetween(-5,5) // starting x
        position.y = randBetween(-5,5) // starting y
        position.z = -100 // starting z, start far away and move towards positive z
        
        //attach point light source
        let lightNode = SCNNode()
        lightNode.position.x = 0
        lightNode.position.y = 0
        lightNode.position.z = 0
        let l = SCNLight()
        l.color = colour
        l.type = .omni
        lightNode.light = l
        
        addChildNode(lightNode)
        runAction(SCNAction.move(to: SCNVector3(position.x, position.y, 100.0), duration: getDuration(orbsPassed)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // check if the orb has passed the ship, if it has it should be deleted
    func hasPassed() -> Bool {
        return position.z >= 0
    }
    func hasFinishedTravel() -> Bool {
        return position.z >= 100
    }
    private func randBetween(_ lower: Float, _ upper:Float) -> Float {
        return Float(drand48()) * (upper-lower) + lower
    }
    private func getDuration(_ orbsPassed:Int) -> Double {
        let distance = 120.0
        let speed = randBetween(15, 20+2*sqrt(Float(orbsPassed)))
        print("Duration ", distance / Double(speed))
        return distance / Double(speed)
    }
}
