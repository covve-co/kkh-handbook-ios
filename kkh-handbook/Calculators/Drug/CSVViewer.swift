//
//  CSVViewer.swift
//  kkh-handbook
//
//  Created by Sean Lim on 12/6/18.
//  Copyright © 2018 sstinc. All rights reserved.
//

import Foundation
import UIKit

extension DrugView: UIWebViewDelegate {
	func viewForCsv (_ data:Data) -> UIViewController {
		var webView = UIWebView()
		let file = "TEMP.csv"
		
		if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
			
			let path = dir.appendingPathComponent(file)
			// Write data to csv file
			do {
				try data.write(to: path, options: .atomic)
			} catch {/* error handling here */}
			
			// Garbage code sets up webview
			webView = UIWebView.init(frame: CGRect.init(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
			webView.loadRequest(URLRequest.init(url: path))
			webView.isMultipleTouchEnabled = true
			webView.scrollView.isMultipleTouchEnabled = true
			webView.scrollView.maximumZoomScale = 2
			webView.scrollView.minimumZoomScale = 0.5
			webView.scrollView.setZoomScale(2, animated: true)
			webView.delegate = self
			webView.scalesPageToFit = true
			
		
		}
		
		let ctrl = UIViewController()
		ctrl.view.addSubview(webView)
		
		return ctrl

	}
}
