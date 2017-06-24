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
	@IBOutlet fileprivate weak var profileImage: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!

	fileprivate var identifier: String = "ProfileViewController"
	fileprivate var viewModel: ProfileViewModel!
	
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
		
		let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "More"), style: .plain, target: self, action: #selector(moreButtonHit(_:))) 
		navigationItem.rightBarButtonItem = moreButton
		
		profileImage.layer.borderWidth = 0.5
		profileImage.layer.cornerRadius = profileImage.frame.size.width/2
		profileImage.clipsToBounds = true
		nameLabel.text = viewModel.activeAccount.name
//		yearsPlayedLabel.text = "\(viewModel.activeAccount.yearsPlayed) years"
//		zipcodeLabel.text = "\(viewModel.activeAccount.zipcode)"
			
		profileImage.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 20).isActive = true
//		informationStackView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 5).isActive = true
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Control Handlers
	
	// MARK: Private
	@objc fileprivate func moreButtonHit(_ sender: UIButton) {
		
	}
	
	// MARK: Public
	

}
