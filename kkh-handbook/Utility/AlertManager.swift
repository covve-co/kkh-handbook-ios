//
//  AlertManager.swift
//
//  Created by Sean Lim on 19/1/18.
//
//
import Foundation
import UIKit


public class AlertManager {
	
	var alertController: UIAlertController = UIAlertController()
	
	var targetViewController: UIViewController?
	var style: UIAlertControllerStyle?
	var title: String?
	var message: String?
	var actions: [UIAlertAction]?
	
	init(target: UIViewController, type: UIAlertControllerStyle) {
		self.targetViewController = target
		self.style = type
	}
	
	func withFields(title: String? = "Alert Title", message: String? = "Alert description") -> AlertManager {
		self.title = title
		self.message = message
		return self
		
	}
	
	func addAction(actionTitle: String?,
				   style: UIAlertActionStyle = .default,
				   withCallback: ((_ : UIAlertAction) -> Void)?) -> AlertManager {
		let action = UIAlertAction.init(title: actionTitle ?? "Dismiss", style: style, handler: withCallback)
		if self.actions != nil{
			self.actions!.append(action)
			
		}
		else{
			self.actions = [action]
			
		}
		return self
		
	}
	
	// Endpoint of interface
	func throwsAlert() -> Void {
		self.targetViewController?.presentAlertView(title: self.title ?? "Alert", message: self.message ??  "Description",style: style ??  .alert , actions: self.actions ?? [])
		
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
	func presentAlertView (title : String, message : String, style: UIAlertControllerStyle, actions : [UIAlertAction]) {
		let av = UIAlertController.init(title: title, message: message, preferredStyle: style)
		actions.forEach { av.addAction($0) }
		av.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
		self.present(av, animated: true, completion: nil)
		
	}
	
}
