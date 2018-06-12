//
//  DrugView.swift
//  kkh-handbook
//
//  Created by Sean Lim on 11/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class DrugView: GlobalController, UITextFieldDelegate {
	
	@IBOutlet var header: UIView!
	@IBOutlet var wrapper: UIView!
	@IBOutlet var wrapperHeader: UIView!
	@IBOutlet var weightField: UITextField!
	@IBOutlet var feedback: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		header.drawGradientBackground(color1: .appBlue(), color2: .appBlueSecondary())
		header.roundify(15)
		wrapper.roundify(10)
		wrapperHeader.drawGradientBackground(color1: .appPink(), color2: .appPinkSecondary())
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		if weightField.text != "" && weightField.text!.valueCheck() != nil {
			feedback.text = "Calculating for patient of weight \(weightField.text!.valueCheck()!)"
			feedback.textColor = .black
		} else {
			feedback.text = "Please enter valid weight"
			feedback.textColor = .red
		}
	}
	
	func showActionSheet (title: String, manager: DrugManager) {
		let controller = viewForCsv(manager.getData()!)
		controller.title = title
		
		let a = UIAlertController(title: title, message: "Select action", preferredStyle: .actionSheet)
		a.addAction(UIAlertAction(title: "View Results", style: .default, handler: { _ in
			self.navigationController?.pushViewController(controller, animated: true)
		}))
		a.addAction(UIAlertAction(title: "Email", style: .default, handler: { _ in
			manager.sendEmail(self)
		}))
		a.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
		
		self.present(a, animated: true, completion: nil)
	}
}

extension DrugView: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if weightField.text != "" && weightField.text!.valueCheck() != nil {
			let weight = Int(weightField.text!)!
			if indexPath.row < 3 {
				var manager: DrugManager? {
					switch indexPath.row {
					case 0: return CardiacDrugCalculationsManager(weight: weight)
					case 1: return AnaesthesiaDrugCalculationsManager(weight: weight)
					case 2: return ScoliosisDrugCalculationsManager(weight: weight)
					default: return nil
					}
				}
				showActionSheet(title: ["Cardiac", "Anaesthesia", "Scoliosis"][indexPath.row], manager: manager!)
			} else {
				
			}
		} else {
			AlertManager.newAlert.to(self)
				.withTitle("Invalid patient weight")
				.withMessage("Please input a valid weight value")
				.addAction("Dismiss") { _ in
					
				}
				.throwsAlert()
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DrugCell
		var title :String {
			switch indexPath.row {
			case 0: return "Cardiac"
			case 1: return "Anaesthesia"
			case 2: return "Scoliosis"
			case 3: return "Common"
			default: return ""
			}
		}
		cell.title.text = title
		return cell
	}
	
}

class DrugCell: UITableViewCell {
	@IBOutlet var title: UILabel!
	
}
