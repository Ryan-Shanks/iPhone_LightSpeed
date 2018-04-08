//
//  GameViewController.swift
//  LightSpeed
//
//  Created by Ryan Shanks on 3/27/18.
//  Copyright © 2018 wlu. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController, SCNPhysicsContactDelegate{
    
    private var scene = SCNScene()
    private var game: GameLogic? = nil
    private var controls:ControlOverlay? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = GameLogic(scene)
        //print("Creating view")
        
        //delegate so we can have frame by frame logic
        let scnview = self.view as! SCNView
        scnview.delegate = game
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        //create a weak light at the camera so the scene never goes completely dark
        let cl = SCNLight()
        cl.color = UIColor.white
        cl.type = .ambient
        cl.intensity = 50
        cameraNode.light = cl
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // true allows the user to manipulate the camera
        scnView.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = false
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        //disable default lighting when there are no lights
        scnView.autoenablesDefaultLighting = false
        
        //add the controls
        controls = ControlOverlay(fileNamed: "ControlOverlay.sks")
        controls?.game = game // give the controls a reference to the game controller to send key presses
        scnView.overlaySKScene = controls // have the controls render on top of the scenekit window
        game?.controls = controls // also give the game a reference to the controls so it can update the score
        scene.physicsWorld.contactDelegate = self // Contact between the ship and an orb (game over) will be handled here, so we can unwind back to the menu
    }
    
    override var shouldAutorotate: Bool {
        return true // but only supports the 2 landscape configurations
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
    // Game over, store 5 highest scores in UserDefaults
	func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
		let defaults = UserDefaults.standard
		
		var top: [Int] = []
		if let array = defaults.array(forKey: "scores") as? [Int] {
			top = array
		}
		var topSet = Set<Int>(top)
		topSet.insert(game!.orbsPassed)
		top = Array(topSet)
		top.sort(by: >)
		top = Array(top.prefix(5))
        
        defaults.setValue(top.contains(game!.orbsPassed), forKey: "isHighScore")
		
		defaults.setValue(top, forKey: "scores")
		defaults.synchronize()
		dismiss(animated: true, completion: nil)
	}

}
