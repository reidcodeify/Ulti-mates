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
	@IBOutlet fileprivate weak var nameLabel: UILabel!
	@IBOutlet fileprivate weak var collectionView: UICollectionView!

	fileprivate var identifier: String = "ProfileViewController"
	fileprivate var viewModel: ProfileViewModel!
	
	// MARK: Life Cycle
	init (viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		collectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "Profile Cell")

        // Do any additional setup after loading the view.
		self.hideKeyboardWhenScreenTapped()
		
		let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "More"), style: .plain, target: self, action: #selector(moreButtonHit(_:)))
		navigationItem.rightBarButtonItem = moreButton
		
		profileImage.layer.borderWidth = 0.5
		profileImage.layer.cornerRadius = profileImage.frame.size.width/2
		profileImage.clipsToBounds = true
		nameLabel.text = viewModel.activeAccount.name
			
		profileImage.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 20).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Control Handlers
	
	// MARK: Private
	@objc fileprivate func moreButtonHit(_ sender: UIButton) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Edit", style: .default) { action in
			// allow editing of information
			
		})
		alert.addAction(UIAlertAction(title: "Log out", style: .default) { action in
			// sign the user out by taking away credentials from keychain, and transitioning to welcome view controller
			
		})
		alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	// MARK: Public

}

// MARK: Extension
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4 //viewModel.activeAccount.favoritedEvents.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Profile Cell", for: indexPath)
		cell.backgroundView?.backgroundColor = .blue
		return cell
	}
}
