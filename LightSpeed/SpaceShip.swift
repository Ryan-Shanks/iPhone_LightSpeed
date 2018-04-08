//
//  SpaceShip.swift
//  LightSpeed
//
//  Created by Ryan Shanks on 3/27/18.
//  Represents the ship that the user can fly, which can move in 2 dimensions in the 3d space
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit
class SpaceShip: SCNNode{
    
    private var vertRotationNode = SCNNode() // easier to combine rotations if we just stick everything in this node, apply some rotations here and some on the main one
    
    private let MOVE_SPEED = 10.0
    private let ROTATION:Float = 30
    private let ROTATION_FLAT = SCNVector4(0,0,0,0)
    private let ROTATION_LEFT = SCNVector4(0,0,1, 30.0 * Double.pi / 180.0)
    private let ROTATION_RIGHT = SCNVector4(0,0,1, -30.0 * Double.pi / 180.0)
    private let ROTATION_UP = SCNVector4(1,0,0, 30 * Double.pi / 180)
    private let ROTATION_DOWN = SCNVector4(1,0,0, -30 * Double.pi / 180)
    
    private let Y_BOUND:Float = 3.9
    private let X_BOUND:Float = 5.8
    
    private var keysDown: UInt8 = 0
    override init(){
        super.init()
        let bodyNode = createBody()
        let leftUpperWing = createWing(rotation: 15)
        let leftLowerWing = createWing(rotation: -15)
        let rightUpperWing = createWing(rotation: 165)
        let rightLowerWing = createWing(rotation: 195)
        
        vertRotationNode.addChildNode(bodyNode)
        vertRotationNode.addChildNode(leftUpperWing)
        vertRotationNode.addChildNode(leftLowerWing)
        vertRotationNode.addChildNode(rightUpperWing)
        vertRotationNode.addChildNode(rightLowerWing)
        addChildNode(vertRotationNode)
        
        scale = SCNVector3(x:0.4, y:0.4,z:0.4)
        
        physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(node: self, options: nil))
        physicsBody?.categoryBitMask = PhysicsCategory.Ship
        physicsBody?.contactTestBitMask = PhysicsCategory.Orb
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setMaterials(_ geo: SCNGeometry){
        geo.firstMaterial?.lightingModel = .phong
        geo.firstMaterial?.shininess = 70
        geo.firstMaterial?.specular.contents = UIColor.white
        geo.firstMaterial?.specular.intensity = 500
        geo.firstMaterial?.diffuse.contents = UIColor.white
    }
    //Create a node containing a wing and rotate it around the z axis to allow for the creation of the 4 wings
    private func createWing(rotation:Float) -> SCNNode {
        //Create the wing, which is just a rectangle
        let nodeWing = SCNNode()
        let body = SCNBox(width: 6, height: 0.1, length: 4, chamferRadius: 0)
        setMaterials(body)
        //print(body.materials)
        nodeWing.geometry = body
        
        //Create the wing tip which is another rectangle but it is rotated 45 degrees and at the end of the rest of the wing to form a point
        let nodeWingTip = SCNNode()
        let wingTipGeo = SCNBox(width: sqrt(8), height: 0.1, length: sqrt(8), chamferRadius: 0)
        setMaterials(wingTipGeo)
        
        nodeWingTip.geometry = wingTipGeo
        nodeWingTip.position.x = 3
        nodeWingTip.rotation = SCNVector4(0,1,0,GLKMathDegreesToRadians(45))
        
        nodeWing.addChildNode(nodeWingTip)
        
        let rotationNode = SCNNode()
        rotationNode.rotation = SCNVector4(0,0,1, rotation * (Float.pi / 180.0))
        nodeWing.position.x = 4
        nodeWing.position.y = 0
        nodeWing.position.z = 0
        nodeWing.geometry = body
        rotationNode.addChildNode(nodeWing)
        return rotationNode
    }
    private func createBody() -> SCNNode{
        let body = SCNSphere()
        
        body.radius = 2.0
        setMaterials(body)
        let node = SCNNode()
        node.position.x = 0
        node.position.y = 0
        node.position.z = 0
        node.geometry = body
        node.scale = SCNVector3(x:1,y:1,z:2)
        return node
    }
    //Setter for the keysPressed variable
    func setKeysDown(_ keysPressed:UInt8){
        keysDown = keysPressed
    }
    //Ensure the space ship does not go off screen
    func keepInBounds() {
        if position.x < -X_BOUND {
            position.x = -X_BOUND
        }else if position.x > X_BOUND {
            position.x = X_BOUND
        }
        
        if position.y < -Y_BOUND{
            position.y = -Y_BOUND
        } else if position.y > Y_BOUND {
            position.y = Y_BOUND
        }
    }
    
    //Called before each frame is rendered to update the position of the ship assuming the same keys are still down
    func tick(elapsed: TimeInterval){
        
        if keysDown & ArrowKeys.VERT == ArrowKeys.UP{
            position.y += Float(MOVE_SPEED * elapsed)
            vertRotationNode.rotation = ROTATION_UP
        } else if keysDown & ArrowKeys.VERT == ArrowKeys.DOWN {
            position.y -= Float(MOVE_SPEED * elapsed)
            vertRotationNode.rotation = ROTATION_DOWN
        } else {
            vertRotationNode.rotation = ROTATION_FLAT
        }
        
        
        if keysDown & ArrowKeys.HORIZ == ArrowKeys.LEFT {
            position.x -= Float(MOVE_SPEED * elapsed)
            rotation = ROTATION_LEFT
        } else if keysDown & ArrowKeys.HORIZ == ArrowKeys.RIGHT {
            position.x += Float(MOVE_SPEED * elapsed)
            rotation = ROTATION_RIGHT
        }else {
            rotation = ROTATION_FLAT
        }
        keepInBounds()
        //print("Position x ", position.x, " y ", position.y)
    }
}
