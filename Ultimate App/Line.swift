//
//  Line.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/28/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class Line: UIView {
	
	override func draw(_ rect: CGRect) {
		let aPath = UIBezierPath()
		aPath.move(to: CGPoint(x: 0, y: 1))
		aPath.addLine(to: CGPoint(x: 250, y: 1))
		aPath.close()
		UIColor.blue.set()
		aPath.stroke()
	}
}
