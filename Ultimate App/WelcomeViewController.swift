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
	@IBOutlet fileprivate weak var scrollView: UIScrollView!
	@IBOutlet fileprivate weak var signUpButton: UIButton!
	@IBOutlet fileprivate weak var logInButton: UIButton!
	@IBOutlet fileprivate weak var selectionLine: UIView!
	
	// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.hideKeyboardWhenScreenTapped()
		
		var createAccountView = CreateAccountViewController().view!
		var signInView = SignInViewController().view!
		

		let views: [UIView] = [createAccountView, signInView]
		
		var previousView: UIView? = nil
		var index = 0
		for pageView in views {
			pageView.translatesAutoresizingMaskIntoConstraints = false
			
			scrollView.addSubview(pageView)
			
			if let previous = previousView {
				scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .leading, relatedBy: .equal, toItem: previous, attribute: .trailing, multiplier: 1, constant: 0))
			} else {
				scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0))
			}
			
			scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": pageView]))
			scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0))
			scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0))
			
			if index == (views.count - 1) {
				scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: 0))
			} else {
				previousView = pageView
			}
			
			index += 1
		}

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	@IBAction func selectionMade(_ sender: UIButton) {
		let buttonCenterToMatch = sender.center.x
		var slidePosition: CGFloat
		
		if (sender.tag == 0) {
			slidePosition = 0
		} else {
			slidePosition = view.bounds.width
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			self.selectionLine.center.x = buttonCenterToMatch
			self.scrollView.contentOffset.x = slidePosition
		})
	}
	
	
	// MARK: Private
	
	
	// MARK: Public
	
}

extension WelcomeViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		print("\(scrollView.contentOffset.x)") // it's the left edge of current view
		
	}
}
