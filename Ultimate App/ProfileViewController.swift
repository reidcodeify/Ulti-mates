//
//  ProfileViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class ProfileViewController: UIViewController {
	// MARK: Properties
	@IBOutlet private weak var profileImage: UIImageView!
	@IBOutlet private weak var profileLabel: UILabel!
	@IBOutlet private weak var yearsPlayedLabel: UILabel!
	@IBOutlet private weak var zipcodeLabel: UILabel!
	@IBOutlet private weak var biographyTextView: UITextView!
	
	private var identifier: String = "ProfileViewController"
	private var viewModel: ProfileViewModel!
	
	// MARK: Life Cycle
	init (viewModel: ProfileViewModel) {
		super.init(nibName: identifier, bundle: nil)
		self.viewModel = viewModel
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.hideKeyboardWhenScreenTapped()
		
		profileImage.layer.borderWidth = 1.0
		profileImage.layer.borderColor = UIColor.black.cgColor
		profileImage.layer.cornerRadius = profileImage.frame.size.width/2
		profileImage.clipsToBounds = true
		profileLabel.text = "\(viewModel.account.name)"
		yearsPlayedLabel.text = "\(viewModel.account.yearsPlayed) years"
		zipcodeLabel.text = "\(viewModel.account.zipcode)"
		biographyTextView.layer.borderWidth = 1.0
		biographyTextView.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Control Handlers
	
	// MARK: Private
	
	// MARK: Public
	

}
