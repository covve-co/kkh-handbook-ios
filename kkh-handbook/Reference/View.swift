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
	
	var bookmarkedOnly: Bool = false
	
	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var bookmarkToggle: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Bind to model
		model.bind(self)
		
		// 3D Touch
		registerForPreviewing(with: self , sourceView: tableView)
		
		bookmarkToggle.tintColor = .lightGray
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	@IBAction func bookmarkToggle(_ sender: Any) {
		bookmarkToggle.tintColor = bookmarkToggle.tintColor == .lightGray ? .bookmarkOrange():.lightGray
	
		bookmarkedOnly = !bookmarkedOnly
		
		tableView.reloadData()
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



