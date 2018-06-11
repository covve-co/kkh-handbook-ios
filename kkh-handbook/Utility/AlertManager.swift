//
//  AlertManager.swift
//
//  Created by Sean Lim on 19/1/18.
//
//
import Foundation
import UIKit


public class AlertManager {
	
	static let newAlert = AlertManager()
	
	var targetViewController: UIViewController?
	var title: String?
	var message: String?
	var actions: [UIAlertAction]?
	
	func to(_ target : UIViewController) -> AlertManager {
		self.targetViewController = target
		return self
		
	}
	
	func withTitle(_ titleInput: String) -> AlertManager {
		self.title = titleInput
		return self
		
	}
	
	func addAction(_ actionTitle: String?, withCallback: @escaping (_ : UIAlertAction) -> Void) -> AlertManager {
		let action = UIAlertAction.init(title: actionTitle ?? "Dismiss", style: .default, handler: withCallback)
		if self.actions != nil{
			self.actions!.append(action)
			
		}
		else{
			self.actions = [action]
			
		}
		return self
		
	}
	
	func withMessage(_ errorMessage: String) -> AlertManager {
		self.message = errorMessage
		return self
		
	}
	
	// Endpoint of interface
	func throwsAlert () -> Void {
		self.targetViewController?.presentAlertView(title: self.title ?? "Alert", message: self.message ?? "no Description provided", actions: self.actions ?? [])
		
		// Cleans
		self.cleans()
		
	}
	
	// Resets
	private func cleans() {
		self.title = nil
		self.message = nil
		self.actions = nil
		self.targetViewController = nil
		
	}
	
}

// Extends UIViewController
extension UIViewController {
	func presentAlertView (title : String, message : String, actions : [UIAlertAction]) {
		let av = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
		actions.forEach { av.addAction($0) }
		self.present(av, animated: true, completion: nil)
		
	}
	
}
