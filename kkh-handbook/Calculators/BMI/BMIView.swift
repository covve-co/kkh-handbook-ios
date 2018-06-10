//
//  View.swift
//  kkh-handbook
//
//  Created by Sean Lim on 10/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class BMICalculatorView: GlobalController, UIPickerViewDelegate {
	
	var model: BMIModel?
	
	var color: UIColor = .appBlue()
	
	@IBOutlet var headerView: UIView!
	@IBOutlet var avatar: UIImageView!
	@IBOutlet var message: UILabel!
	@IBOutlet var bmiLabel: UILabel!
	
	@IBOutlet var genderPicker: UISegmentedControl!
	@IBOutlet var weight: UITextField!
	@IBOutlet var height: UITextField!
	
	override func viewDidLoad() {
		model = BMIModel(bind: self)
		headerView.roundify(15)
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
	}
	
	public func getForm() -> (Bool, Float)? {
		let weight = self.weight.text?.valueCheck()
		let height = self.height.text?.valueCheck()
		
		if weight != nil && height != nil {
			return (genderPicker.selectedSegmentIndex == 0, weight!/(height! * height!) )
		} else {
			return nil
		}
		
	}
	
	
	// Update view
	func update() {
		
	}
	
}

extension BMICalculatorView: UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return 18
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return String(row + 1)
	}
	
	
}
