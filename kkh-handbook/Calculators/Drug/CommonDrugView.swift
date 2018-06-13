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
	case Method
}

class CommonDrugView: UIViewController {
	
	var data: CommonDrugs?
	var drug, path, method : String?
	var type: CommonDrugDataType?
	
	var dispArr: [String]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		switch type! {
		case .CommonDrugs:
			dispArr = data!.keys.map{String($0)}
		case .Paths:
			dispArr = data![drug!]!.keys.map{String($0)}
		case .Methods:
			dispArr = data![drug!]![path!]!.keys.map{String($0)}
		case .Method:
			dispArr = [data![drug!]![path!]![method!]! as! String]
		}
		
	}
}

extension CommonDrugView: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dispArr?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReferenceViewCell
		if type! == .Method {
			//
		}
		cell.label.text = dispArr?[indexPath.row] ?? "nil"
		return cell
	}
	
	
}
