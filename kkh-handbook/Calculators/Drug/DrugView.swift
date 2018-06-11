//
//  DrugView.swift
//  kkh-handbook
//
//  Created by Sean Lim on 11/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class DrugView: GlobalController {
	
	@IBOutlet var header: UIView!
	@IBOutlet var wrapper: UIView!
	@IBOutlet var wrapperHeader: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		header.drawGradientBackground(color1: .appBlue(), color2: .appBlueSecondary())
		header.roundify(15)
		wrapper.roundify(10)
		wrapperHeader.drawGradientBackground(color1: .appPink(), color2: .appPinkSecondary())
	}
}
