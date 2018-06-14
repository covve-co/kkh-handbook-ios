//
//  CrisisMenuCell.swift
//  kkh-handbook
//
//  Created by Sean Lim on 14/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class CrisisMenuCell: UITableViewCell {
	
	@IBOutlet var title: UILabel!
	@IBOutlet var cardView: UIView!
	
	override func awakeFromNib() {
		self.cardView.roundify(10)
		self.cardView.drawGradientBackground(color1: .appPink(), color2: .appPinkSecondary())
	}
}
