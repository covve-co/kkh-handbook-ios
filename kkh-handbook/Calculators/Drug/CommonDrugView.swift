//
//  CommonDrugView.swift
//  kkh-handbook
//
//  Created by Sean Lim on 12/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

// Data-driven rendering
enum  CommonDrugDataType {
	case CommonDrugs
	case Paths
	case Methods
}

class CommonDrugView: UIViewController {
	
	var data: CommonDrugs?
	var type: CommonDrugDataType?
	
	var dispArr: [String]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		switch type! {
		case .CommonDrugs:
			dispArr = data!.keys.map{String($0)}
		default:
			<#code#>
		}
	}
}

extension CommonDrugView: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (data! as! [String: Any]).keys.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReferenceViewCell
		let title = switch data {
		case data! as! CommonDrugs:
			return data!.map{$0}[indexPath.row]
		case data as! Paths:
		case data as! Methods:
		default:
			break
		}
	}
	
	
}
