//
//  PlayerCardViewController.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 8/18/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class PlayerCardViewController: UIViewController {
	// MARK: Properties
	fileprivate let identifier: String = "PlayerCardViewController"
	
	@IBOutlet fileprivate weak var firstNameLabel: UILabel!
	@IBOutlet fileprivate weak var lastNameLabel: UILabel!
	
	fileprivate let viewModel: PlayerCardViewModel
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init (viewModel: PlayerCardViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print("\(identifier) was dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	// MARK: Private
	
	// MARK: Public

}
