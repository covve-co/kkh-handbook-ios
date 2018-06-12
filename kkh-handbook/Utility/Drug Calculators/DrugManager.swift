//
//  DrugManager.swift
//  kkh-handbook
//
//  Created by Sean Lim on 12/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

protocol DrugManager {
	init(weight: Int)
	func getData() -> Data?
}
