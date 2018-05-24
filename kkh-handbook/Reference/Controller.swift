//
//  Reference.swift
//  kkh-handbook
//
//  Created by Sean Lim on 17/5/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

final class ReferenceView: GlobalController, UISearchBarDelegate {
	
	var model = ReferenceViewModel()
	
	var sections = 1
	var rows = 0
	
	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Bind to model
		model.bind(self)
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		model.searching = true
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		model.searching = false
		model.build()
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		model.search(query: searchBar.text)
		print(model.content)
	}
	
	
}


