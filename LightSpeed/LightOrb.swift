//
//  LightOrb.swift
//  LightSpeed
//
//  Created by user136098 on 3/27/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import Foundation
import SceneKit
class LightOrb: SCNNode {
    let sphere = SCNSphere(radius: 1.0)
    var finished = false
    override init(){
        super.init()
        geometry = sphere
        position.x = Float(drand48() * 8.0 - 4.0) // starting x
        position.y = Float(drand48() * 8.0 - 4.0) // starting y
        position.z = -100 // starting z, start far away and move towards positive z
        runAction(SCNAction.move(to: SCNVector3(position.x, position.y, 20.0), duration: 2))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
