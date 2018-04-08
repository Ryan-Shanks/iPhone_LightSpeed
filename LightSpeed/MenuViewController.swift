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
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let defaults = UserDefaults.standard
		
		let scores = defaults.array(forKey: "scores") as? [Int] ?? []
		
		let scoresString = scores.map {
			$0.description
		}.joined(separator: ", ")
		topScores.text = "High Scores: \(scoresString)"
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
