//
//  PreviewingDelegate.swift
//  kkh-handbook
//
//  Created by Sean Lim on 9/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

extension ReferenceView: UIViewControllerPreviewingDelegate {
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		if previewingContext.sourceView == tableView {
			guard let indexPath = tableView.indexPathForRow(at: location) else {
				return nil
			}
			return content[indexPath.section].1[indexPath.row].buildController()
		}
		else {
			return nil
		}
	}
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
		self.navigationController?.navigationBar.prefersLargeTitles = false
		self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
	}
}
