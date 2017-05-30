//
//  Extensions.swift
//
//  Created by Travis Ouellette on 10/23/16.
//  Copyright © 2016 Codeify. All rights reserved.
//

import UIKit
import LocalAuthentication

extension UIView {
	func roundAndShadow () {
		self.layer.cornerRadius = self.bounds.height/2
		self.layer.shadowOpacity = 0.2
		self.layer.shadowOffset = CGSize(width: 1, height: 2)
	}
	
	func createWhiteBorder () {
		self.layer.borderColor = UIColor.white.cgColor
		self.layer.borderWidth = 2.0
		self.layer.cornerRadius = 3
	}
}

extension UITextField {
		func indentAndUnderline() {
			let border = CALayer()
			let width = CGFloat(1)
			border.borderColor = UIColor(red: 246/255, green: 246/255, blue: 248/255, alpha: 0.75).cgColor
			border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
			
			border.borderWidth = width
			self.layer.addSublayer(border)
			self.layer.masksToBounds = true
			
			let spacerView = UIView(frame:CGRect(x: 0, y: 0, width: 20, height: 10))
			self.leftViewMode = UITextFieldViewMode.always
			self.leftView = spacerView
		}
}

extension UIViewController {
	func hideKeyboardWhenScreenTapped() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	func dismissKeyboard() {
		view.endEditing(true)
	}
	
	var visibleViewController: UIViewController? {
		// If there are no child view controllers, or the root view has no subviews, return nil
		if childViewControllers.count == 0 || view.subviews.count == 0 {
			return nil
		}
		
		// Iterate through all the child view controllers, keeping track of the subview index
		var topmostChildVC: UIViewController? = nil
		var currentTopmostSubviewIndex: Int = -1
		childViewControllers.forEach { childVC in
			guard let subviewIndex = view.subviews.index(of: childVC.view) else {
				return
			}
			
			// If the subviewIndex is greater than the currentTopmostSubviewIndex, update currentTopmostSubviewIndex and set topmostChildVC
			if subviewIndex > currentTopmostSubviewIndex {
				currentTopmostSubviewIndex = subviewIndex
				topmostChildVC = childVC
			}
		}
		
		// If we have found a topmostChildVC, return it
		if let visibleChild = topmostChildVC {
			return visibleChild
		}
		
		return nil
	}
	
	func setInitialViewController(_ viewController: UIViewController) {
		addChildViewController(viewController)
		viewController.view.frame = view.frame
		view.addSubview(viewController.view)
		viewController.didMove(toParentViewController: self)
	}
	
	func fadeToChildViewController(_ viewController: UIViewController) {
		guard let visible = visibleViewController else {
			setInitialViewController(viewController)
			return
		}
		
		visible.willMove(toParentViewController: nil)
		addChildViewController(viewController)
		
		viewController.view.alpha = 0
		viewController.view.frame = view.frame
		view.addSubview(viewController.view)
		
		func finishTransition() {
			visible.view.removeFromSuperview()
			visible.removeFromParentViewController()
			viewController.didMove(toParentViewController: self)
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			viewController.view.alpha = 1
		}, completion: { finished in
			finishTransition()
		})
	}
	
	func navigateToChildViewController(_ viewController: UIViewController) {
		guard let visible = visibleViewController else {
			setInitialViewController(viewController)
			return
		}
		
		visible.willMove(toParentViewController: nil)
		addChildViewController(viewController)
		
		viewController.view.frame = CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
		view.addSubview(viewController.view)
		
		func finishTransition() {
			visible.view.removeFromSuperview()
			visible.removeFromParentViewController()
			viewController.didMove(toParentViewController: self)
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			viewController.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
			}, completion: { finished in
				finishTransition()
		})
	}
}

extension Double {
	func roundTo(places:Int) -> Double {
		let divisor = pow(10.0, Double(places))
		return (self * divisor).rounded() / divisor
	}
}

extension UIColor {
	convenience init(r: Int, g: Int, b: Int, alpha: CGFloat) {
		self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: alpha)
	}
	
	func lighten(_ saturationMultiplier: CGFloat = 0.5) -> UIColor {
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		
		getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		
		return UIColor(hue: hue, saturation: saturation * saturationMultiplier, brightness: brightness, alpha: alpha)
	}
}

extension UserDefaults {
	func isFirstLaunch() -> Bool {
		if !UserDefaults.standard.bool(forKey: "HasAtLeastLaunchedOnce") {
			UserDefaults.standard.set(true, forKey: "HasAtLeastLaunchedOnce")
			UserDefaults.standard.synchronize()
			print("first launch bro")
			return true
		}
		
		print("not first launch bro")
		return false
	}
}
