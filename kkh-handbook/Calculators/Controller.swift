//
//  MenuController.swift
//  kkh-handbook
//
//  Created by Sean Lim on 10/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class CalculatorController: GlobalController {
	
	@IBOutlet var BMIView: UIView!
	@IBOutlet var DrugView: UIView!
	
	override func viewDidLoad() {
		[BMIView, DrugView].forEach{$0.roundify(15)}
	}
	
	@IBAction func BMIPressed(_ sender: Any) {
		self.performSegue(withIdentifier:"bmi", sender: self)
	}
	
	@IBAction func drugPressed(_ sender: Any) {
		self.performSegue(withIdentifier: "drug", sender: self)
	}
	
	
}	
