//
//  Model.swift
//  kkh-handbook
//
//  Created by Sean Lim on 10/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit
import Charts

struct BMIModel {
	var viewInstance: BMICalculatorView?
	
	init(bind instance: BMICalculatorView) {
		viewInstance = instance
	}
	
	func updateChart () {
		let age = viewInstance!.agePicker.selectedRow(inComponent: 0) + 1
		let ismale = viewInstance!.genderPicker.selectedSegmentIndex == 0
		viewInstance?.chart.data = BMIGraphManager().getChartData(age: age, isMale: ismale)
	}
	
	func notifyFormChanged() {
		self.updateChart()
		if let (ismale, bmiValue, age) = viewInstance!.getForm() {
			let m = BMIGraphManager(age: age, bmi: bmiValue, isMale: ismale)
			let res = m.range()
			
			var msg: String {
				switch res {
				case 1:  return "Patient is severely underweight"
				case 2:  return "Patient is underweight"
				case 3:  return "Patient is of acceptable weight"
				case 4:  return "Patient is overweight"
				case 5:  return "Patient is severely overweight"
				default: return "Please enter valid patient details"
				}
			}
			
			viewInstance?.update(message: msg, BMI: bmiValue)
			
		}
	}
	
}
