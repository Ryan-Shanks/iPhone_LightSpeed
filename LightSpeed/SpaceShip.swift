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
    override init(){
        super.init()
        let bodyNode = createBody()
        let leftUpperWing = createWing(rotation: 15)
        let leftLowerWing = createWing(rotation: -15)
        let rightUpperWing = createWing(rotation: 165)
        let rightLowerWing = createWing(rotation: 195)
        
        addChildNode(bodyNode)
        addChildNode(leftUpperWing)
        addChildNode(leftLowerWing)
        addChildNode(rightUpperWing)
        addChildNode(rightLowerWing)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createWing(rotation:Float) -> SCNNode {
        let shape = SCNBox(width: 6, height: 0.1, length: 4, chamferRadius: 20)
        //shape.firstMaterial?.emission.contents = UIColor.darkGray
        //shape.firstMaterial?.emission.intensity = 0.5
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
        body.firstMaterial?.shininess = 100
        body.firstMaterial?.specular.contents = UIColor.white
        body.radius = 2.0
        body.firstMaterial?.lightingModel = .phong
        body.firstMaterial?.ambient.contents = UIColor.white
        //body.firstMaterial?.emission.contents = UIColor.darkGray
        //body.firstMaterial?.emission.intensity = 0.5
        
        let node = SCNNode()
        node.position.x = 0
        node.position.y = 0
        node.position.z = 0
        node.geometry = body
        node.scale = SCNVector3(x:1,y:1,z:3)
        return node
    }
}
