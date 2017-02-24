//
//  PremiumController.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 24/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import Alamofire
import Stripe
import SwiftSpinner

class PremiumController: UIViewController, WKNavigationDelegate, STPAddCardViewControllerDelegate {
	
	public func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
		
		SwiftSpinner.show("Please hold...")
		
		Alamofire.request(Router.payment(token: token.tokenId)).responseJSON { response in
			if response.result.isSuccess, let result = response.result.value {
				
				var alert: UIAlertController
				self.dismiss(animated: true, completion: nil)

				if response.response?.statusCode == 201 {
					alert = UIAlertController(title: "Premium Confirmed", message: "Thank you for purchasing premium. Please check your email for a purchase receipt", preferredStyle: UIAlertControllerStyle.alert)
					alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
				} else {
					alert = UIAlertController(title: "There was an issue", message: "There was an issue confirming your payment. Please contact support", preferredStyle: UIAlertControllerStyle.alert)
					alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
				}
				
				self.present(alert, animated: true, completion: nil)
			}
			
			SwiftSpinner.hide()
		}
	}

	/**
	*  Called when the user cancels adding a card. You should dismiss (or pop) the view controller at this point.
	*
	*  @param addCardViewController the view controller that has been cancelled
	*/
	public func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
		self.dismiss(animated: true, completion: nil)
	}

	var webView : WKWebView!
	
	override func viewDidLoad() {
		super.viewDidLoad()

		self.title = "Go Premium"
		
		// loading URL :
		let premium = "https://subterminal.eu/premium"
		let url = NSURL(string: premium)
		let request = NSURLRequest(url: url! as URL)
		
		// init and load request in webview.
		webView = WKWebView(frame: self.view.frame)
		webView.navigationDelegate = self
		webView.load(request as URLRequest)

		self.view.addSubview(webView)
		self.view.sendSubview(toBack: webView)
	}
	
	func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
		print(error.localizedDescription)
	}
	
	//Make sure user is authenticated before proceeding to payment
	func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		if let urlStr = navigationAction.request.url?.absoluteString{
			if (urlStr.range(of: "?payment=true") != nil) {
				
				Alamofire.request(Router.updateUser()).responseJSON { response in
					var statusCode = response.response?.statusCode
					
					if statusCode == 201 {
						let addCardViewController = STPAddCardViewController()
						addCardViewController.delegate = self
						
						// STPAddCardViewController must be shown inside a UINavigationController.
						let navigationController = UINavigationController(rootViewController: addCardViewController)
						self.present(navigationController, animated: true, completion: nil)

					} else {
						let alert = UIAlertController(title: "Not Authenticated", message: "Please sign in before proceeding", preferredStyle: UIAlertControllerStyle.alert)
						alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
						self.present(alert, animated: true, completion: nil)
					}
				}
				
			}
		}
		decisionHandler(.allow)
	}
	
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		print("finish to load")
	}
}
