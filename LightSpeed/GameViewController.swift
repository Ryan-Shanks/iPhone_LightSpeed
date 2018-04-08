//
//  GameViewController.swift
//  LightSpeed
//
//  Created by user136098 on 3/27/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController{
    
    private var scene = SCNScene()
    private var game: GameLogic? = nil
    private var controls:ControlOverlay? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = GameLogic(scene)
        print("Creading view")
        
        //delegate so we can have frame by frame rendering
        let scnview = self.view as! SCNView
        scnview.delegate = game
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        //create a weak light at the camera so the scene never goes completely dark
        let cl = SCNLight()
        cl.color = UIColor.white
        cl.type = .ambient
        cl.intensity = 100
        cameraNode.light = cl
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        // create and add a light to the scene
        //let lightNode = SCNNode()
        //lightNode.light = SCNLight()
        //lightNode.light!.type = .omni
        //lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        //scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        //let ambientLightNode = SCNNode()
        //ambientLightNode.light = SCNLight()
        //ambientLightNode.light!.type = .ambient
        //ambientLightNode.light!.color = UIColor.darkGray
        //scene.rootNode.addChildNode(ambientLightNode)
    
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // true allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        //disable default lighting when there are no lights
        scnView.autoenablesDefaultLighting = false
        
        //add the controls
        controls = ControlOverlay(fileNamed: "ControlOverlay.sks")
        controls?.game = game
        scnView.overlaySKScene = controls
        game?.controls = controls
        scene.physicsWorld.contactDelegate = game
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    

}
