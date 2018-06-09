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
	
	var content: [Chapter] = []
	
	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Bind to model
		model.bind(self)
		
		// 3D Touch
		registerForPreviewing(with: self , sourceView: tableView)
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		model.searching = true
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		model.searching = false
		model.build()
	}
	
	func searchBar(_ searchBar: UISearchBar,
				   textDidChange searchText: String) {
		// Mutating search
		model.search(query: searchBar.text == "" ? nil : searchBar.text)
	}
	
}



