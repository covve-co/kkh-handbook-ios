//
//  Cell.swift
//  kkh-handbook
//
//  Created by Sean Lim on 18/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class ReferenceViewCell: UITableViewCell {
	@IBOutlet var label: UILabel!

}

class ReferenceSectionHeader: UIView {
	@IBOutlet var label: UILabel!
	class func instanceFromNib() -> ReferenceSectionHeader {
		return UINib(nibName: "Section header", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ReferenceSectionHeader
	}
}
