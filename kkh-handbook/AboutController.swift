//
//  AboutController.swift
//  kkh-handbook
//
//  Created by Sean Lim on 15/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class AboutController: GlobalController {
	
	@IBOutlet var buttonCollection: [UIButton]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		buttonCollection.forEach { button in
			button.roundify(10)
		}
	}
	
	@IBAction func ButtonPress(_ sender: Any) {
		let v = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "crisisContent") as! CrisisContent
		switch (sender as! UIButton).tag {
		case 0:
			v.name = "Disclaimer"
			v.data = ContentManager.specialThanks()
		case 1:
			v.name = "More info"
			v.data = ContentManager.specialThanks()
		default: break
		}
		
		self.present(v, animated: true, completion: nil)
	}
}
