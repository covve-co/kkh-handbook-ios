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
			dispArr = (data![drug!]![path!]![method!]! as! [String: Any]).map{"\($0.key): \($0.value as! String)"}
		}
		
	}
}

extension CommonDrugView: UITableViewDelegate, UITableViewDataSource{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let v = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "commonDrugs") as! CommonDrugView
		
		v.data = self.data!
		v.drug = self.drug
		v.path = self.path
		v.method = self.method
		v.title =  dispArr![indexPath.row]
		
		if self.type! == .CommonDrugs {
			v.type = .Paths
			v.drug = dispArr![indexPath.row]
		}
		else if self.type! == .Paths {
			v.type = .Methods
			v.path = dispArr![indexPath.row]
		}
		else if self.type! == .Methods {
			v.type = .Method
			v.method = dispArr![indexPath.row]
		}
		
		self.navigationController?.pushViewController(v, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dispArr?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell: UITableViewCell?
		if type! == .Method {
			//
			cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! DetailCell
			print(dispArr?[indexPath.row])
			(cell as! DetailCell).contentLabel.text = dispArr?[indexPath.row] ?? "nil"
			cell!.isUserInteractionEnabled = false
			cell!.selectionStyle = .none
		} else {
			cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ReferenceViewCell
			(cell as! ReferenceViewCell).indicator.alpha = 0
			(cell as! ReferenceViewCell).label.text = dispArr?[indexPath.row] ?? "nil"
		}
		
		return cell!
	}
	
	
}
