//
//  CrisisController.swift
//  kkh-handbook
//
//  Created by Sean Lim on 14/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

class CrisisController: GlobalController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.navigationController?.tabBarController?.tabBar.tintColor = .appPink()
	}
}
