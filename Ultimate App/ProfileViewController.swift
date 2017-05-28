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
	@IBOutlet weak var informationStackView: UIStackView!
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
		
		profileImage.layer.borderWidth = 0.5
		profileImage.layer.borderColor = UIColor.black.cgColor
		profileImage.layer.cornerRadius = profileImage.frame.size.width/2
		profileImage.clipsToBounds = true
		yearsPlayedLabel.text = "\(viewModel.account.yearsPlayed) years"
		zipcodeLabel.text = "\(viewModel.account.zipcode)"
		
		navigationItem.title = "\(viewModel.account.name)"
		
		profileImage.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 5).isActive = true
		informationStackView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 5).isActive = true
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Control Handlers
	
	// MARK: Private
	
	// MARK: Public
	

}
