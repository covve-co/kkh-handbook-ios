//
//  CrisisMenu.swift
//  kkh-handbook
//
//  Created by Sean Lim on 14/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class CrisisMenu: GlobalController {
	
	@IBOutlet var tableView: UITableView!
	
	@IBOutlet var headerView: UIView!
	var weight: Float?
	
	@IBOutlet var weightLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		headerView.drawGradientBackground(color1: .appBlue(), color2: .appBlueSecondary())
		weightLabel.text = "\(Int(weight!)) KG"
	}
	
	override func transitionSetup() {
		self.tableView.hero.modifiers = [.translate(y:300), .opacity(0)]
	}
	
}

extension CrisisMenu: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CrisisMenuCell
		cell.title.text = [
			"Basic Life Support (BLS)",
			"Cardiac Arrest",
			"LA Toxicity",
			"Hyperkalaemia",
			"Malignant Hyperthermia",
			"Anaphylaxis"
		][indexPath.row]
		return cell
	}
	
}

class CrisisMenuCell: UITableViewCell {
	
	@IBOutlet var title: UILabel!
	@IBOutlet var cardView: UIView!
	
	override func awakeFromNib() {
		self.cardView.roundify(10)
		self.cardView.drawGradientBackground(color1: .appPink(), color2: .appPinkSecondary())
	}
}
