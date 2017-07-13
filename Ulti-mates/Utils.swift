//
//  Utils.swift
//
//  Created by Travis Ouellette on 11/8/16.
//  Copyright © 2016 Codeify. All rights reserved.
//

import Foundation

func DLog(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
	#if DEBUG
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm:ss.SSS"
		
		let date: Date = Date()
		let time: String = dateFormatter.string(from: date)
		
		var fileName: String = file
		let fileURL: NSURL = NSURL(fileURLWithPath: file)
		
		if let fileNameWithExtension: String = fileURL.lastPathComponent {
			fileName = fileNameWithExtension.components(separatedBy: ".")[0]
		}
		
		var thread: String
		if Thread.isMainThread {
			thread = "main"
		} else {
			thread = "background"
		}
		
		print("\(time): \(thread) - \(fileName).\(function) (\(line)):\n\(message)\n")
	#endif
}

fileprivate let DILogEnabled = false
func DILog(_ message: String, file: String = #file, function: String = #function, line: Int = #line) {
	#if DEBUG
		if !DILogEnabled {
			return
		}
		
		let dateFormatter: DateFormatter = DateFormatter()
		dateFormatter.dateFormat = "h:mm:ss.SSS"
		
		let date: Date = Date()
		let time: String = dateFormatter.string(from: date)
		
		var fileName: String = file
		let fileURL: NSURL = NSURL(fileURLWithPath: file)
		
		if let fileNameWithExtension: String = fileURL.lastPathComponent {
			fileName = fileNameWithExtension.components(separatedBy: ".")[0]
		}
		
		var thread: String
		if Thread.isMainThread {
			thread = "main"
		} else {
			thread = "background"
		}
		
		print("\(time): \(thread) - \(fileName).\(function) (\(line)):\n\(message)\n")
	#endif
}

class UpdatableProperty<T> {
	// MARK: Properties
	typealias Update = (T) -> ()
	fileprivate var update: Update?
	
	private(set) var value: T {
		didSet {
			update?(value)
		}
	}
	
	// MARK: Life Cycle
	init(value: T) {
		self.value = value
	}
	
	// MARK: Public
	func bind(_ fire: Bool = true, _ update: @escaping Update) {
		self.update = update
		
		if fire {
			self.update?(value)
		}
	}
	
	func unbind() {
		update = nil
	}
	
	func update(_ newValue: T) {
		value = newValue
	}
	
}
