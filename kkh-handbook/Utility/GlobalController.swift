//
//  Global.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit
import Hero

class GlobalController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.hero.navigationAnimationType = .fade
		transitionSetup()
		UILabel.appearance(whenContainedInInstancesOf: [UIAlertController.self]).numberOfLines = 0
	}
	
	func transitionSetup() {}
}

class CircleView: UIView {
	override func draw(_ rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()
		self.tintColor.setFill()
		CGContext.fillEllipse(context!)(in: rect)
	}
}
