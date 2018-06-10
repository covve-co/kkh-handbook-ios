//
//  Extensions.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
	static func bookmarkOrange() -> UIColor {
		return  UIColor(red:1.00, green:0.84, blue:0.00, alpha:1.0)
	}
	
	static func appBlue() -> UIColor {
		return UIColor(red:0.36, green:0.56, blue:0.78, alpha:1.0)
	}
	
	static func appPink() -> UIColor {
		return UIColor(red:0.90, green:0.56, blue:0.71, alpha:1.0)
	}
	
}

public extension String {
	func valueCheck() -> Float? {
		var result: Float? = nil
		do {
			let regex = try NSRegularExpression(pattern: "^(?:|0|[1-9]\\d*)(?:\\.\\d*)?$", options: [])
			let results = regex.matches(in: self, options: [], range: NSMakeRange(0, self.count))
			if results.count > 0 {result = (self as NSString).floatValue}
		} catch let error as NSError {
			print("invalid regex: \(error.localizedDescription)")
		}
		return result
	}
}
