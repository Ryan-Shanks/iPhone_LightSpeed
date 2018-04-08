//
//  MenuViewController.swift
//  LightSpeed
//
//  Created by Ryan Shanks on 2018-04-07.
//  Copyright © 2018 wlu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
	@IBOutlet weak var topScores: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	//Show the top scores, can get them from user defaults as they will already have been sent there by the gameviewcontoller
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let defaults = UserDefaults.standard
		let scores = defaults.array(forKey: "scores") as? [Int] ?? []
		var scoresString = scores.map {
			$0.description
		}.joined(separator: ", ")
        
        if defaults.bool(forKey: "isHighScore") {
            scoresString += "\nHigh Score!"
        }
        
		topScores.text = "High Scores: \(scoresString)"
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
