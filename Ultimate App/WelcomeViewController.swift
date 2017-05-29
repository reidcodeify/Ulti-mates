//
//  WelcomeViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/28/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class WelcomeViewController: UIViewController {
	// MARK: Properties
	@IBOutlet fileprivate weak var signUpButton: UIButton!
	@IBOutlet fileprivate weak var logInButton: UIButton!
	@IBOutlet fileprivate weak var selectionLine: UIView!
	
	// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		signUpButton.isOpaque = true
		logInButton.isOpaque = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	@IBAction func selectionMade(_ sender: UIButton) {
		let buttonCenterToMatch = sender.center.x
		
		UIView.animate(withDuration: 0.5, animations: {
			self.selectionLine.center.x = buttonCenterToMatch
		})
	}
	
	
	// MARK: Private
	
	
	// MARK: Public
}
