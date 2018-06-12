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
	
	@IBOutlet var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Bind to model
		model.bind(self)
		
		// 3D Touch
		registerForPreviewing(with: self , sourceView: tableView)
				
		let searchController = UISearchController(searchResultsController: nil) // Search Controller
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationItem.searchController = searchController
		searchController.searchBar.delegate = self
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	
	@IBAction func bookmarkToggle(_ sender: Any) {
		let actionSheet = AlertManager.init(target: self, type: .actionSheet)
		.withFields(title: "Bookmarks", message: "Select bookmarked chapter")
		
		let files = content.flatMap{$0.1}.filter{$0.isBookmarked}
		files.forEach { file in
			_ = actionSheet.addAction(actionTitle: file.name, withCallback: { _ in
				self.navigationController?.pushViewController(file.buildController(), animated: true)
				self.navigationController?.navigationBar.prefersLargeTitles = false
			})
		}
		actionSheet.addAction(actionTitle: "Cancel", style: .cancel, withCallback: nil)
			.throwsAlert()
	}
	
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		model.searching = true
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		model.searching = false
		model.build()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		model.searching = false
		model.build()
	}
	
	func searchBar(_ searchBar: UISearchBar,
				   textDidChange searchText: String) {
		// Mutating search
		model.search(query: searchBar.text == "" ? nil : searchBar.text)
	}
	
}



