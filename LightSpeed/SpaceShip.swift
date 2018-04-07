//
//  SpaceShip.swift
//  LightSpeed
//
//  Created by user136098 on 3/27/18.
//  Represents the ship that the user can fly, which can move in 2 dimensions in the 3d space
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit
class SpaceShip: SCNNode {
    
    private var vertRotationNode = SCNNode() // easier to combine rotations if we just stick everything in this node, apply some rotations here and some on the main one
    
    private let MOVE_SPEED = 10.0
    private let ROTATION:Float = 30
    private let ROTATION_FLAT = SCNVector4(0,0,0,0)
    private let ROTATION_LEFT = SCNVector4(0,0,1, 30.0 * Double.pi / 180.0)
    private let ROTATION_RIGHT = SCNVector4(0,0,1, -30.0 * Double.pi / 180.0)
    private let ROTATION_UP = SCNVector4(1,0,0, 30 * Double.pi / 180)
    private let ROTATION_DOWN = SCNVector4(1,0,0, -30 * Double.pi / 180)
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setMaterials(_ geo: SCNGeometry){
        //geo.firstMaterial?.emission.contents = UIColor.darkGray
        //geo.firstMaterial?.emission.intensity = 0.5
        geo.firstMaterial?.lightingModel = .phong
        geo.firstMaterial?.shininess = 70
        geo.firstMaterial?.specular.contents = UIColor.white
        geo.firstMaterial?.diffuse.contents = UIColor.white
    }
    private func createWing(rotation:Float) -> SCNNode {
        let shape = SCNBox(width: 6, height: 0.1, length: 4, chamferRadius: 20)
        setMaterials(shape)
        print(shape.materials)
        let node1 = SCNNode()
        let node2 = SCNNode()
        node1.rotation = SCNVector4(0,0,1, rotation * (Float.pi / 180.0))
        node2.position.x = 4
        node2.position.y = 0
        node2.position.z = 0
        node2.geometry = shape
        node1.addChildNode(node2)
        return node1
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

    func setKeysDown(_ keysPressed:UInt8){
        keysDown = keysPressed
    }
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
        //print("Position x ", position.x, " y ", position.y)
    }
}
