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
		return UIColor(red:0.02, green:0.75, blue:1.00, alpha:1.0)
	}
	
	static func appBlueSecondary() -> UIColor {
		return UIColor(red:0.27, green:0.51, blue:0.92, alpha:1.0)
	}
	
	static func appPink() -> UIColor {
		return UIColor(red:1.00, green:0.32, blue:0.59, alpha:1.0)
	}
	
	static func appPinkSecondary() -> UIColor {
		return UIColor(red:0.97, green:0.44, blue:0.38, alpha:1.0)
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

public extension UIView {
	func roundify(_ value: CGFloat) {
		self.layer.cornerRadius = value
		self.clipsToBounds = true
	}
	
	func drawGradientBackground(color1: UIColor, color2: UIColor) {
		let gradient = CAGradientLayer()
		
		gradient.frame = self.bounds
		gradient.colors = [color1.cgColor, color2.cgColor]
		self.layer.insertSublayer(gradient, at: 0)
	}
}

extension Float {
	/// Rounds the double to decimal places value
	func roundTo(places:Int) -> Float {
		let divisor = pow(10.0, Float(places))
		return (self * divisor).rounded() / divisor
	}
	
	var cleanUpper:String {
		if rint(self) == self {
			return String(Int(self))
		}
		else{
			return String(Float(self))
		}
	}
	
}
