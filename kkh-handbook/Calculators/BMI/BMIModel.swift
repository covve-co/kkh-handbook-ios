//
//  Model.swift
//  kkh-handbook
//
//  Created by Sean Lim on 10/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

struct BMIModel {
	var viewInstance: BMICalculatorView?
	
	init(bind: BMICalculatorView) {
		viewInstance = bind
	}
	
	func notifyFormChanged() {
		if let (ismale, bmiValue) = viewInstance!.getForm() {
		}
	}
	
}
