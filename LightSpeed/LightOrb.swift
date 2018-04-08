//
//  LightOrb.swift
//  LightSpeed
//
//  Created by Ryan Shanks on 3/27/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit
import UIKit
class LightOrb: SCNNode {
    
    var finished = false
    static let colorOptions:[UIColor] = [.red, .blue, .yellow, .green, .cyan, .orange, .magenta]
    
    init(orbsPassed: Int){
        super.init()
        let sphere = SCNSphere(radius: 0.75) // create a sphere
        geometry = sphere
        sphere.firstMaterial?.lightingModel = .phong
        let colour = LightOrb.colorOptions[Int(randBetween(0.0, Float(LightOrb.colorOptions.count-1)))] // choose a color from the list of choices
        //Set all properties of the sphere to that color
        sphere.firstMaterial?.emission.contents = colour
        sphere.firstMaterial?.ambient.contents = colour
        sphere.firstMaterial?.diffuse.contents = colour
        
        //Define the physics for the sphere, only used for hit testing against the ship
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(geometry: sphere, options: nil))
        physicsBody?.categoryBitMask = PhysicsCategory.Orb
        physicsBody?.contactTestBitMask = PhysicsCategory.Ship
        
        //Randomly choose x and y coordinates for the sphere, some may end up slightly off screen but oh well the player can still worry about them
        position.x = randBetween(-6,6) // starting x
        position.y = randBetween(-5,5) // starting y
        position.z = -100 // starting z, start far away and move towards positive z
        
        //attach point light source which is inside the sphere and is the same color
        let l = SCNLight()
        l.color = colour
        l.type = .omni
        light = l

        //Animate the orb to move from its current position 100 in front of the ship to 100 behind the ship
        runAction(SCNAction.move(to: SCNVector3(position.x, position.y, 100.0), duration: getDuration(orbsPassed)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    // check if the orb has passed the ship, if it has it should cound towards the score
    func hasPassed() -> Bool {
        return position.z >= 0
    }
    //check if the orb is far enough passed to delete
    func hasFinishedTravel() -> Bool {
        return position.z >= 100
    }
    //helper func for generating random numbers
    private func randBetween(_ lower: Float, _ upper:Float) -> Float {
        return Float(drand48()) * (upper-lower) + lower
    }
    //decides how long the orb should take to fly from -100 to +100
    private func getDuration(_ orbsPassed:Int) -> Double {
        let distance = 120.0 // no longer the true distance but I think its better faster anyway
        let speed = randBetween(15, 20+5*sqrt(Float(orbsPassed)))
        return distance / Double(speed)
    }
}
